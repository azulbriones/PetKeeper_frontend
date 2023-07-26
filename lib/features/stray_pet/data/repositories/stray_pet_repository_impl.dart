// import 'dart:io';

import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class StrayPetRepositoryImpl implements StrayPetRepository {
  final StrayPetRemoteDataSource strayPetRemoteDataSource;

  StrayPetRepositoryImpl({required this.strayPetRemoteDataSource});
  @override
  Future<List<StrayPet>> createStrayPet(StrayPet strayPet) async {
    return await strayPetRemoteDataSource.createStrayPet(strayPet);
  }

  @override
  Future<String> deleteStrayPet(String petId) async {
    return await strayPetRemoteDataSource.deleteStrayPet(petId);
  }

  @override
  Future<List<StrayPet>> getAllStrayPets() async {
    return await strayPetRemoteDataSource.getAllStrayPets();
  }

  // @override
  // Future<List<StrayPet>> getStrayPetsByOwnerId(String ownerId) async {
  //   return await strayPetRemoteDataSource.getStrayPetsByOwnerId(ownerId);
  // }

  // @override
  // Future<List<StrayPet>> getStrayPetsByRescuerId(String rescuerId) async {
  //   return await strayPetRemoteDataSource.getStrayPetsByRescuerId(rescuerId);
  // }

  @override
  Future<StrayPet> getStrayPetById(String petId) async {
    return await strayPetRemoteDataSource.getStrayPetById(petId);
  }

  // @override
  // Future<List<StrayPet>> getStrayPetsByLocation(String location) async {
  //   return await strayPetRemoteDataSource.getStrayPetsByLocation(location);
  // }

  // @override
  // Future<List<StrayPet>> getStrayPetsByLostDate(DateTime lostDate) async {
  //   return await strayPetRemoteDataSource.getStrayPetsByLostDate(lostDate);
  // }

  // @override
  // Future<List<StrayPet>> getStrayPetsByStatus(String status) async {
  //   return await strayPetRemoteDataSource.getStrayPetsByStatus(status);
  // }

  // @override
  // Future<StrayPet> updateStrayPet(StrayPet strayPet, File petImage) async {
  //   return await strayPetRemoteDataSource.updateStrayPet(strayPet, petImage);
  // }
}
