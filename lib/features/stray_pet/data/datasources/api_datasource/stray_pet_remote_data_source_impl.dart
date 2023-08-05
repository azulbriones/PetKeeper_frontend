import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

String apiURL = serverURL;

class StrayPetRemoteDataSourceImpl implements StrayPetRemoteDataSource {
  @override
  Future<void> createStrayPet(StrayPet strayPet) async {
    final firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    final file = File(strayPet.petImage.path);
    await storageRef.putFile(file);
    final imageUrl = await storageRef.getDownloadURL();

    String reward;
    if (strayPet.reward == '') {
      reward = '0';
    } else {
      reward = strayPet.reward;
    }

    // Generar un nuevo documento con un ID automático
    final newDocumentRef =
        FirebaseFirestore.instance.collection('stray_pets').doc();

    final data = {
      'pet_name': strayPet.petName,
      'pet_breed': strayPet.petBreed,
      'age': strayPet.age,
      'description': strayPet.description,
      'location': strayPet.location,
      'address': strayPet.address,
      'status': 'lost',
      'reward': reward,
      'owner_id': strayPet.ownerId,
      'owner_name': strayPet.ownerName,
      'lost_date': strayPet.lostDate,
      'payment': '0',
      'pet_image': imageUrl,
      'created_at': DateTime.now(),
    };

    // Establecer los datos en el documento recién creado
    await newDocumentRef.set(data);

    // Notifica que se creó correctamente el post de Adopt Pet
    toastOk('Adopt Pet Post created successfully');
  }

  @override
  Future<void> deleteStrayPet(String petId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final DocumentReference docRef =
          firestore.collection('stray_pets').doc(petId);

      // Elimina el documento de la colección "adopt_pets"
      await docRef.delete();

      toastOk("Stray Pet deleted successfully");
    } catch (e) {
      throw Exception('Failed to delete Stray Pet');
    }
  }

  @override
  Future<List<StrayPetModel>> getAllStrayPets() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('stray_pets')
        .orderBy('created_at', descending: true)
        .get();

    List<StrayPetModel> strayPets = snapshot.docs
        .map((DocumentSnapshot doc) =>
            StrayPetModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return strayPets;
  }

  @override
  Future<StrayPetModel> getStrayPetById(String petId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('stray_pets')
        .doc(petId)
        .get();

    return StrayPetModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByRescuerId(String rescuerId) async {
    var url = Uri.http(apiURL, '/strayPets?rescuer_id=$rescuerId');

    var response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decodifica el JSON de la respuesta y crea una lista de StrayPetModel
      List<dynamic> jsonData = jsonDecode(response.body);
      List<StrayPetModel> strayPets =
          jsonData.map((data) => StrayPetModel.fromJson(data)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to load stray pets by rescuer ID');
    }
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByOwnerId(String? ownerId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('stray_pets')
        .where('owner_id', isEqualTo: ownerId)
        .get();

    List<StrayPetModel> strayPets = snapshot.docs.map((doc) {
      return StrayPetModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return strayPets;
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByLocation(String location) async {
    var url = Uri.http(apiURL, '/strayPets?location=$location');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<StrayPetModel> strayPets =
          jsonData.map((json) => StrayPetModel.fromJson(json)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to get stray pets by location');
    }
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByLostDate(String lostDate) async {
    var url = Uri.http(apiURL, '/strayPets?lost_date=$lostDate');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<StrayPetModel> strayPets =
          jsonData.map((json) => StrayPetModel.fromJson(json)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to get stray pets by lost date');
    }
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByStatus(String status) async {
    var url = Uri.http(apiURL, '/strayPets?status=$status');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<StrayPetModel> strayPets =
          jsonData.map((json) => StrayPetModel.fromJson(json)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to get stray pets by status');
    }
  }

  // @override
  // Future<void> updateStrayPet(String strayPetId, String status) async {
  //   StrayPetModel strayPetModel = await getStrayPetById(strayPetId);

  //   final data = {
  //     'pet_name': strayPetModel.petName,
  //     'pet_breed': strayPetModel.petBreed,
  //     'age': strayPetModel.age,
  //     'description': strayPetModel.description,
  //     'location': strayPetModel.location,
  //     'address': strayPetModel.address,
  //     'reward': strayPetModel.reward,
  //     'status': status,
  //     'owner_id': strayPetModel.ownerId,
  //     'owner_name': strayPetModel.ownerName,
  //     'payment': '0',
  //     'lost_date': DateTime.now().toString(),
  //   };

  //   var request = http.MultipartRequest(
  //       'PUT', Uri.http(apiURL, '/strayPets/$strayPetId'));
  //   request = jsonToFormData(request, data);

  //   final response = await request.send();
  //   print(response.statusCode);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     toastOk('Stray Pet Post updated successfully');
  //   } else {
  //     throw Exception();
  //   }
  // }

  @override
  Future<void> updateStatusStrayPet(String strayPetId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('stray_pets')
          .doc(strayPetId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update status of Adopt pet: $e');
    }
  }
}
