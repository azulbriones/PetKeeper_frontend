import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/adopt_pet/data/models/adopt_pet_model.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

String apiURL = serverURL;

class AdoptPetRemoteDataSourceImpl implements AdoptPetRemoteDataSource {
  @override
  Future<void> createAdoptPet(AdoptPet adoptPet) async {
    final firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    final file = File(adoptPet.petImage.path);
    await storageRef.putFile(file);
    final imageUrl = await storageRef.getDownloadURL();

    // Generar un nuevo documento con un ID automático
    final newDocumentRef =
        FirebaseFirestore.instance.collection('adopt_pets').doc();

    final data = {
      'id': newDocumentRef.id, // Agregar el valor del ID generado
      'pet_name': adoptPet.petName,
      'pet_breed': adoptPet.petBreed,
      'age': adoptPet.age,
      'description': adoptPet.description,
      'location': adoptPet.location,
      'address': adoptPet.address,
      'status': adoptPet.status,
      'owner_id': adoptPet.ownerId,
      'owner_name': adoptPet.ownerName,
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
  Future<void> deleteAdoptPet(String petId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final DocumentReference docRef =
          firestore.collection('adopt_pets').doc(petId);

      // Elimina el documento de la colección "adopt_pets"
      await docRef.delete();

      toastOk("Adopt Pet deleted successfully");
    } catch (e) {
      throw Exception('Failed to delete Adopt Pet');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAllAdoptPets() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('adopt_pets')
        .orderBy('created_at', descending: true)
        .get();

    List<AdoptPetModel> adoptPets = snapshot.docs
        .map((DocumentSnapshot doc) =>
            AdoptPetModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return adoptPets;
  }

  @override
  Future<AdoptPetModel> getAdoptPetById(String petId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('adopt_pets')
        .doc(petId)
        .get();

    return AdoptPetModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByNewOwnerId(
      String newOwnerId) async {
    var url = Uri.http(apiURL, '/adoptPets?new_owner_id=$newOwnerId');

    var response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decodifica el JSON de la respuesta y crea una lista de AdoptPetModel
      List<dynamic> jsonData = jsonDecode(response.body);
      List<AdoptPetModel> adoptPets =
          jsonData.map((data) => AdoptPetModel.fromJson(data)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to load Adopt pets by rescuer ID');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByOwnerId(String? ownerId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('adopt_pets')
        .where('owner_id', isEqualTo: ownerId)
        .get();

    List<AdoptPetModel> adoptPets = snapshot.docs.map((doc) {
      return AdoptPetModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return adoptPets;
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByLocation(String location) async {
    var url = Uri.http(apiURL, '/adoptPets?location=$location');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<AdoptPetModel> adoptPets =
          jsonData.map((json) => AdoptPetModel.fromJson(json)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to get sAdopt pets by location');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByAdoptDate(String adoptDate) async {
    var url = Uri.http(apiURL, '/adoptPets?adopt_date=$adoptDate');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<AdoptPetModel> adoptPets =
          jsonData.map((json) => AdoptPetModel.fromJson(json)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to get sAdopt pets by lost date');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByStatus(String status) async {
    var url = Uri.http(apiURL, '/adoptPets?status=$status');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<AdoptPetModel> adoptPets =
          jsonData.map((json) => AdoptPetModel.fromJson(json)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to get sAdopt pets by status');
    }
  }

  @override
  Future<AdoptPetModel> updateAdoptPet(AdoptPet adoptPet) async {
    var url = Uri.http(apiURL, '/${adoptPet.id}');
    var headers = {'Content-Type': 'application/json'};

    var jsonBody = jsonEncode(adoptPet.toJson()); // Convertir a JSON

    var request = http.MultipartRequest('UPDATE', url);
    request.headers.addAll(headers);

    // Agregar el JSON al cuerpo de la solicitud
    request.fields['data'] = jsonBody;

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decodificar la respuesta JSON y devolver el SAdoptPet actualizado
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      return AdoptPetModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to update Adopt pet');
    }
  }

  @override
  Future<void> updateStatusAdoptPet(String adoptPetId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('adopt-pets')
          .doc(adoptPetId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update status of Adopt pet: $e');
    }
  }
}
