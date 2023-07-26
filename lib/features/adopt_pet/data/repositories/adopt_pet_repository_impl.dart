// import 'dart:io';

import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class AdoptPetRepositoryImpl implements AdoptPetRepository {
  final AdoptPetRemoteDataSource adoptPetRemoteDataSource;

  AdoptPetRepositoryImpl({required this.adoptPetRemoteDataSource});
  @override
  Future<List<AdoptPet>> createAdoptPet(AdoptPet adoptPet) async {
    return await adoptPetRemoteDataSource.createAdoptPet(adoptPet);
  }

  @override
  Future<String> deleteAdoptPet(String petId) async {
    return await adoptPetRemoteDataSource.deleteAdoptPet(petId);
  }

  @override
  Future<List<AdoptPet>> getAllAdoptPets() async {
    return await adoptPetRemoteDataSource.getAllAdoptPets();
  }

  // @override
  // Future<List<AdoptPet>> getAdoptPetsByOwnerId(String ownerId) async {
  //   return await adoptPetRemoteDataSource.getAdoptPetsByOwnerId(ownerId);
  // }

  // @override
  // Future<List<AdoptPet>> getAdoptPetsByNewOwnerId(String newOwnerId) async {
  //   return await adoptPetRemoteDataSource.getAdoptPetsByNewOwnerId(newOwnerId);
  // }

  @override
  Future<AdoptPet> getAdoptPetById(String petId) async {
    return await adoptPetRemoteDataSource.getAdoptPetById(petId);
  }

  // @override
  // Future<List<AdoptPet>> getAdoptPetsByLocation(String location) async {
  //   return await adoptPetRemoteDataSource.getAdoptPetsByLocation(location);
  // }

  // @override
  // Future<List<AdoptPet>> getAdoptPetsByAdoptDate(String adoptDate) async {
  //   return await adoptPetRemoteDataSource.getAdoptPetsByAdoptDate(adoptDate);
  // }

  // @override
  // Future<List<AdoptPet>> getAdoptPetsByStatus(String status) async {
  //   return await adoptPetRemoteDataSource.getAdoptPetsByStatus(status);
  // }

  // @override
  // Future<AdoptPet> updateAdoptPet(AdoptPet adoptPet, File petImage) async {
  //   return await adoptPetRemoteDataSource.updateAdoptPet(adoptPet, petImage);
  // }
}
