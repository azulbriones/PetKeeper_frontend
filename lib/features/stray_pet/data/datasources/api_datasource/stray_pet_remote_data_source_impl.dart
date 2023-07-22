import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:intl/intl.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_keeper_front/global/config/config.dart';

String apiURL = serverURL;

class StrayPetRemoteDataSourceImpl implements StrayPetRemoteDataSource {
  @override
  Future<List<StrayPetModel>> createPost(StrayPet strayPetData) async {
    var url = Uri.https(apiURL, '/');

    final data = {
      'petName': strayPetData.petName,
      'petBreed': strayPetData.petBreed,
      'ownerId': strayPetData.ownerId,
      'ownerName': strayPetData.ownerName,
      'address': strayPetData.address,
      'lostedDate': strayPetData.lostedDate,
      'reward': strayPetData.reward,
      'age': strayPetData.age,
      'description': strayPetData.description,
      'status': 'lost',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('https://$apiURL$url'));
    request = jsonToFormData(request, data);
    request.headers['X-Requested-With'] = "XMLHttpRequest";
    request.headers['Authorization'] = "";

    request.files.add(await http.MultipartFile.fromPath(
        'petImage', strayPetData.petImage!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      List<StrayPetModel> listUpdatedCreated = await getAllPosts();
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
  Future<List<StrayPetModel>> getAllPosts() async {
    var url = Uri.http(apiURL, '/strays-pets/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return convert
          .jsonDecode(response.body)
          .map<StrayPetModel>((data) => StrayPetModel.fromJson(data))
          .toList();
    } else {
      throw Exception();
    }

    // if (response.statusCode == 200) {
    //   List<StrayPetModel> postList = [];
    //   var responseDecoded = convert.jsonDecode(response.body);
    //   var payLoad = responseDecoded['pay_load'];
    //   print(payLoad);

    //   if (payLoad.length > 0) {
    //     for (var object in payLoad) {
    //       StrayPetModel profileStrayPetModelTemp =
    //           StrayPetModel.fromJson(object);
    //       postList.add(profileStrayPetModelTemp);
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
  Future<List<StrayPetModel>> getPostByOwnerId(int ownerId) async {
    var url = Uri.https(apiURL, '/$ownerId');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<StrayPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          StrayPetModel profileStrayPetModelTemp =
              StrayPetModel.fromJson(object);
          postList.add(profileStrayPetModelTemp);
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
  Future<List<StrayPetModel>> getPostByRescuerId(int rescuerId) async {
    var url = Uri.https(apiURL, '/$rescuerId');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<StrayPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          StrayPetModel profileStrayPetModelTemp =
              StrayPetModel.fromJson(object);
          postList.add(profileStrayPetModelTemp);
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
  Future<StrayPetModel> getPostDetail(int postId) async {
    var url = Uri.http(apiURL, '/strays-pets/$postId');
    var response = await http.get(url);
    print('URL DE DETAIL: ${url}');

    if (response.statusCode == 200) {
      var reponseData = convert.jsonDecode(response.body);
      print(convert.jsonDecode(response.body));
      return StrayPetModel.fromJson(reponseData['pay_load']);
    } else {
      print('error');
      throw Exception();
    }
  }

  @override
  Future<List<StrayPetModel>> getPostsByAddress(String address) async {
    var url = Uri.https(apiURL, '/$address');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<StrayPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          StrayPetModel profileStrayPetModelTemp =
              StrayPetModel.fromJson(object);
          postList.add(profileStrayPetModelTemp);
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
  Future<List<StrayPetModel>> getPostsByLostedDate(String lostedDate) async {
    var url = Uri.https(apiURL, '/$lostedDate');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<StrayPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          StrayPetModel profileStrayPetModelTemp =
              StrayPetModel.fromJson(object);
          postList.add(profileStrayPetModelTemp);
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
  Future<List<StrayPetModel>> getPostsByStatus(String status) async {
    var url = Uri.https(apiURL, '/$status');
    var headers = {'Authorization': ''};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<StrayPetModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          StrayPetModel profileStrayPetModelTemp =
              StrayPetModel.fromJson(object);
          postList.add(profileStrayPetModelTemp);
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
  Future<String> updatePost(StrayPet strayPet) async {
    var url = Uri.https(apiURL, '/post/update/$strayPet.id');
    var headers = {'Authorization': '', 'Content-Type': 'application/json'};

    final body = {
      'status': 'found',
      'rescuerId': strayPet.rescuerId,
      'rescuerName': strayPet.rescuerName
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
