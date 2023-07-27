import 'dart:io';

import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

abstract class StrayPetRemoteDataSource {
  Future<List<StrayPetModel>> createStrayPet(StrayPet strayPet);
  Future<List<StrayPetModel>> getAllStrayPets();
  Future<StrayPetModel> getStrayPetById(String petId);
  Future<StrayPetModel> updateStrayPet(StrayPet strayPet, File petImage);
  Future<String> deleteStrayPet(String petId);
  Future<List<StrayPetModel>> getStrayPetsByOwnerId(String? ownerId);
  Future<List<StrayPetModel>> getStrayPetsByRescuerId(String rescuerId);
  Future<List<StrayPetModel>> getStrayPetsByLocation(String location);
  Future<List<StrayPetModel>> getStrayPetsByLostDate(String lostDate);
  Future<List<StrayPetModel>> getStrayPetsByStatus(String status);
}
