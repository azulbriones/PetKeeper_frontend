import 'package:dio/dio.dart';

import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_api_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';

class StrayPetApiDataSourceImpl implements StrayPetApiDataSource {
  final Dio _dio;
  final String _baseUrl;

  StrayPetApiDataSourceImpl(this._dio, this._baseUrl);

  @override
  Future<List<StrayPetModel>> getAllPets() async {
    try {
      final response = await _dio.get('http://107.20.212.148/strays-pets/');
      final List<dynamic> petData = response.data;
      final pets = petData.map((data) => StrayPetModel.fromJson(data)).toList();
      return pets;
    } catch (error) {
      throw Exception('Failed to fetch pets: $error');
    }
  }

  @override
  Future<StrayPetModel> getPetById(int id) async {
    try {
      final response = await _dio.get('http://107.20.212.148/strays-pets/$id');
      final petData = response.data;
      final pet = StrayPetModel.fromJson(petData);
      return pet;
    } catch (error) {
      throw Exception('Failed to fetch pet: $error');
    }
  }

  @override
  Future<void> addNewPet(StrayPetModel pet) async {
    try {
      await _dio.post('http://107.20.212.148/strays-pets/', data: pet.toJson());
    } catch (error) {
      throw Exception('Failed to add new pet: $error');
    }
  }

  @override
  Future<void> deletePet(int id) async {
    try {
      await _dio.delete('http://107.20.212.148/strays-pets/$id');
    } catch (error) {
      throw Exception('Failed to delete pet: $error');
    }
  }

  @override
  Future<List<StrayPetModel>> getPetsByOwnerId(int ownerId) async {
    try {
      final response =
          await _dio.get('http://107.20.212.148/strays-pets/ownerId/$ownerId');
      final List<dynamic> petData = response.data;
      final pets = petData.map((data) => StrayPetModel.fromJson(data)).toList();
      return pets;
    } catch (error) {
      throw Exception('Failed to fetch pets by owner ID: $error');
    }
  }

  @override
  Future<List<StrayPetModel>> getPetsByRescuerId(int rescuerId) async {
    try {
      final response = await _dio
          .get('http://107.20.212.148/strays-pets/rescuerId/$rescuerId');
      final List<dynamic> petData = response.data;
      final pets = petData.map((data) => StrayPetModel.fromJson(data)).toList();
      return pets;
    } catch (error) {
      throw Exception('Failed to fetch pets by rescuer ID: $error');
    }
  }

  @override
  Future<void> updatePet(int id, StrayPetModel pet) async {
    try {
      await _dio.put('http://107.20.212.148/strays-pets/${pet.id}',
          data: pet.toJson());
    } catch (error) {
      throw Exception('Failed to update pet: $error');
    }
  }
}
