import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/adopt_pet/data/models/adopt_pet_model.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_keeper_front/global/config/config.dart';

String apiURL = serverURL;

class AdoptPetRemoteDataSourceImpl implements AdoptPetRemoteDataSource {
  @override
  Future<List<AdoptPetModel>> createPost(AdoptPet adoptPetData) async {
    var url = Uri.https(apiURL, '/');

    final data = {
      'petName': adoptPetData.petName,
      'petBreed': adoptPetData.petBreed,
      'actualOwnerId': adoptPetData.actualOwnerId,
      'actualOwnerName': adoptPetData.actualOwnerName,
      'address': adoptPetData.address,
      'age': adoptPetData.age,
      'description': adoptPetData.description,
      'status': 'to-adopt',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('https://$apiURL$url'));
    request = jsonToFormData(request, data);
    request.headers['X-Requested-With'] = "XMLHttpRequest";
    request.headers['Authorization'] = "";

    request.files.add(await http.MultipartFile.fromPath(
        'petImage', adoptPetData.petImage!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      List<AdoptPetModel> listUpdatedCreated = await getAllPosts();
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
  Future<String> deletePost(int postId) async {
    var url = Uri.https(apiURL, '/post/$postId');
    var headers = {'Content-Type': 'application/json'};

    http.delete(url, headers: headers).then((response) {
      if (response.statusCode == 200) {
        return "Post deleted successfully";
      } else {
        throw Exception();
      }
    });
    return "hola";
  }

  @override
  Future<List<AdoptPetModel>> getAllPosts() async {
    var url = Uri.http(apiURL, '/adopt-pets/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return convert
          .jsonDecode(response.body)
          .map<AdoptPetModel>((data) => AdoptPetModel.fromJson(data))
          .toList();
    } else {
      throw Exception();
    }

    // if (response.statusCode == 200) {
    //   List<AdoptPetModel> postList = [];
    //   var responseDecoded = convert.jsonDecode(response.body);
    //   var payLoad = responseDecoded['pay_load'];
    //   print(payLoad);

    //   if (payLoad.length > 0) {
    //     for (var object in payLoad) {
    //       AdoptPetModel profileAdoptPetModelTemp =
    //           AdoptPetModel.fromJson(object);
    //       postList.add(profileAdoptPetModelTemp);
    //     }

    //     return postList;
    //   } else {
    //     return postList;
    //   }
    // } else {
    //   throw Exception();
    // }
  }

  @override
  Future<List<AdoptPetModel>> getPostByActualOwnerId(int ownerId) async {
    var url = Uri.https(apiURL, '/$ownerId');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<AdoptPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          AdoptPetModel profileAdoptPetModelTemp =
              AdoptPetModel.fromJson(object);
          postList.add(profileAdoptPetModelTemp);
        }

        postList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA =
              DateFormat('dd/MM/yyyy hh:mma').parse(a.createdDate!);
          DateTime dateB =
              DateFormat('dd/MM/yyyy hh:mma').parse(b.createdDate!);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return postList;
      } else {
        return postList;
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<AdoptPetModel>> getPostByNewOwnerId(int rescuerId) async {
    var url = Uri.https(apiURL, '/$rescuerId');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<AdoptPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          AdoptPetModel profileAdoptPetModelTemp =
              AdoptPetModel.fromJson(object);
          postList.add(profileAdoptPetModelTemp);
        }

        postList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA =
              DateFormat('dd/MM/yyyy hh:mma').parse(a.createdDate!);
          DateTime dateB =
              DateFormat('dd/MM/yyyy hh:mma').parse(b.createdDate!);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return postList;
      } else {
        return postList;
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<AdoptPetModel> getPostDetail(int postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURL, '/$postId');
    var headers = {'Authorization': 'Bearer $access'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var reponseData = convert.jsonDecode(response.body);
      return AdoptPetModel.fromJson(reponseData['pay_load']);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<AdoptPetModel>> getPostsByAddress(String address) async {
    var url = Uri.https(apiURL, '/$address');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<AdoptPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          AdoptPetModel profileAdoptPetModelTemp =
              AdoptPetModel.fromJson(object);
          postList.add(profileAdoptPetModelTemp);
        }

        postList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA =
              DateFormat('dd/MM/yyyy hh:mma').parse(a.createdDate!);
          DateTime dateB =
              DateFormat('dd/MM/yyyy hh:mma').parse(b.createdDate!);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return postList;
      } else {
        return postList;
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<AdoptPetModel>> getPostsByStatus(String status) async {
    var url = Uri.https(apiURL, '/$status');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<AdoptPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          AdoptPetModel profileAdoptPetModelTemp =
              AdoptPetModel.fromJson(object);
          postList.add(profileAdoptPetModelTemp);
        }

        postList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA =
              DateFormat('dd/MM/yyyy hh:mma').parse(a.createdDate!);
          DateTime dateB =
              DateFormat('dd/MM/yyyy hh:mma').parse(b.createdDate!);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return postList;
      } else {
        return postList;
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> updatePost(AdoptPet adoptPet) async {
    var url = Uri.https(apiURL, '/post/update/$adoptPet.id');
    var headers = {'Authorization': '', 'Content-Type': 'application/json'};

    final body = {
      'status': 'adopted',
      'newOwnerId': adoptPet.newOwnerId,
      'newOwnerName': adoptPet.newOwnerName
    };

    http
        .patch(url, body: convert.jsonEncode(body), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        return "Updated";
      } else {
        throw Exception();
      }
    });
    return "a";
  }
}
