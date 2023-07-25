import 'dart:io';

import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

abstract class StrayPetRepository {
  Future<List<StrayPet>> createStrayPet(StrayPet strayPet);
  Future<List<StrayPet>> getAllStrayPets();
  Future<StrayPet> getStrayPetById(String petId);
  Future<StrayPet> updateStrayPet(StrayPet strayPet, File petImage);
  Future<String> deleteStrayPet(String petId);
  Future<List<StrayPet>> getStrayPetsByOwnerId(String ownerId);
  Future<List<StrayPet>> getStrayPetsByRescuerId(String rescuerId);
  Future<List<StrayPet>> getStrayPetsByLocation(String location);
  Future<List<StrayPet>> getStrayPetsByLostDate(String lostDate);
  Future<List<StrayPet>> getStrayPetsByStatus(String status);
}
