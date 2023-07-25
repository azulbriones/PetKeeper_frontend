import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/global/config/config.dart';

String apiURL = serverURL;

class StrayPetRemoteDataSourceImpl implements StrayPetRemoteDataSource {
  @override
  Future<List<StrayPetModel>> createStrayPet(StrayPet strayPet) async {
    var url = Uri.https(apiURL, '/strayPets/');

    final data = {
      'pet_name': strayPet.petName,
      'pet_breed': strayPet.petBreed,
      'age': strayPet.age,
      'description': strayPet.description,
      'location': strayPet.location,
      'address': strayPet.address,
      'status': 'lost',
      'reward': strayPet.reward,
      'rescuer_id': strayPet.rescuerId,
      'rescuer_name': strayPet.rescuerName,
      'owner_id': strayPet.ownerId,
      'owner_name': strayPet.ownerName,
      'lost_date': strayPet.lostDate,
      'created_at': strayPet.createdAt,
      'payment': strayPet.payment
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('http://$apiURL$url'));
    request = jsonToFormData(request, data);
    request.headers['X-Requested-With'] = "XMLHttpRequest";

    request.files.add(await http.MultipartFile.fromPath(
        'pet_image', strayPet.petImage!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      List<StrayPetModel> listUpdatedCreated = await getAllStrayPets();
      return listUpdatedCreated;
    } else {
      throw Exception();
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  @override
  Future<String> deleteStrayPet(String petId) async {
    var url = Uri.http(apiURL, '/strayPets/$petId');
    var headers = {'Content-Type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return "StrayPet deleted successfully";
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<StrayPetModel>> getAllStrayPets() async {
    var url = Uri.http(apiURL, '/strayPets/');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea una lista de objetos StrayPetModel
      List<dynamic> jsonData = jsonDecode(response.body);

      List<StrayPetModel> strayPets =
          jsonData.map((json) => StrayPetModel.fromJson(json)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to load stray pets');
    }
  }

  @override
  Future<StrayPetModel> getStrayPetById(String petId) async {
    var url = Uri.http(apiURL, '/strayPets/$petId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea un objeto StrayPetModel
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      StrayPetModel strayPet = StrayPetModel.fromJson(jsonData);

      return strayPet;
    } else {
      throw Exception('Failed to load stray pet by ID');
    }
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByRescuerId(String rescuerId) async {
    var url = Uri.http(apiURL, '/strayPets?rescuer_id=$rescuerId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
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
  Future<List<StrayPetModel>> getStrayPetsByOwnerId(String ownerId) async {
    var url = Uri.http(apiURL, '/strayPets?owner_id=$ownerId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea una lista de StrayPetModel
      List<dynamic> jsonData = jsonDecode(response.body);
      List<StrayPetModel> strayPets =
          jsonData.map((data) => StrayPetModel.fromJson(data)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to load stray pets by owner ID');
    }
  }

  @override
  Future<List<StrayPetModel>> getStrayPetsByLocation(String location) async {
    var url = Uri.http(apiURL, '/strayPets?location=$location');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData) as List<dynamic>;

      List<StrayPetModel> strayPets =
          jsonData.map((json) => StrayPetModel.fromJson(json)).toList();

      return strayPets;
    } else {
      throw Exception('Failed to get stray pets by status');
    }
  }

  @override
  Future<StrayPetModel> updateStrayPet(
      StrayPet strayPet, File? newImage) async {
    var url = Uri.http(apiURL, '/${strayPet.id}');
    var headers = {'Content-Type': 'application/json'};

    var jsonBody = jsonEncode(strayPet.toJson()); // Convertir a JSON

    var request = http.MultipartRequest('UPDATE', url);
    request.headers.addAll(headers);

    // Agregar el nuevo archivo de imagen si se proporciona
    if (newImage != null) {
      var fileStream = http.ByteStream(Stream.castFrom(newImage.openRead()));
      var length = await newImage.length();

      var multipartFile = http.MultipartFile('pet_image', fileStream, length,
          filename: newImage.path);
      request.files.add(multipartFile);
    }

    // Agregar el JSON al cuerpo de la solicitud
    request.fields['data'] = jsonBody;

    var response = await request.send();

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON y devolver el StrayPet actualizado
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      return StrayPetModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to update stray pet');
    }
  }
}
