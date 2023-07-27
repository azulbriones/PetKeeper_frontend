import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/adopt_pet/data/models/adopt_pet_model.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/config/config.dart';

String apiURL = serverURL;

class AdoptPetRemoteDataSourceImpl implements AdoptPetRemoteDataSource {
  @override
  Future<void> createAdoptPet(AdoptPet adoptPet) async {
    final data = {
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
    };

    var request =
        http.MultipartRequest('POST', Uri.http(apiURL, '/adoptPets/'));
    request = jsonToFormData(request, data);
    print('REQUEST: $request');
    request.headers['X-Requested-With'] = "XMLHttpRequest";

    // request.files.add(await http.MultipartFile.fromPath(
    //     'pet_image', adoptPet.petImage!.path));

    final response = await request.send();
    print('RESPONSE DE ADOPT: ${response.statusCode}');
    if (response.statusCode == 200) {
      toast('Adopt Pet Post created successfully');
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
  Future<String> deleteAdoptPet(String petId) async {
    var url = Uri.http(apiURL, '/adoptPets/$petId');
    var headers = {'Content-Type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return "AdoptPet deleted successfully";
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<AdoptPetModel>> getAllAdoptPets() async {
    var url = Uri.http(apiURL, '/adoptPets/');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea una lista de objetos AdoptPetModel
      List<dynamic> jsonData = jsonDecode(response.body);

      List<AdoptPetModel> adoptPets =
          jsonData.map((json) => AdoptPetModel.fromJson(json)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to load Adopt pets');
    }
  }

  @override
  Future<AdoptPetModel> getAdoptPetById(String petId) async {
    var url = Uri.http(apiURL, '/adoptPets/$petId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea un objeto SAdoptPetModel
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      AdoptPetModel adoptPet = AdoptPetModel.fromJson(jsonData);

      return adoptPet;
    } else {
      throw Exception('Failed to load Adopt pet by ID');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByNewOwnerId(
      String newOwnerId) async {
    var url = Uri.http(apiURL, '/adoptPets?new_owner_id=$newOwnerId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
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
    var url = Uri.http(apiURL, '/adoptPets?owner_id=$ownerId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON de la respuesta y crea una lista de AdoptPetModel
      List<dynamic> jsonData = jsonDecode(response.body);
      List<AdoptPetModel> adoptPets =
          jsonData.map((data) => AdoptPetModel.fromJson(data)).toList();

      return adoptPets;
    } else {
      throw Exception('Failed to load Adopt pets by owner ID');
    }
  }

  @override
  Future<List<AdoptPetModel>> getAdoptPetsByLocation(String location) async {
    var url = Uri.http(apiURL, '/adoptPets?location=$location');
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    var response = await http.Client().send(request);

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
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
  Future<AdoptPetModel> updateAdoptPet(
      AdoptPet adoptPet, File? newImage) async {
    var url = Uri.http(apiURL, '/${adoptPet.id}');
    var headers = {'Content-Type': 'application/json'};

    var jsonBody = jsonEncode(adoptPet.toJson()); // Convertir a JSON

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
      // Decodificar la respuesta JSON y devolver el SAdoptPet actualizado
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      return AdoptPetModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to update Adopt pet');
    }
  }
}
