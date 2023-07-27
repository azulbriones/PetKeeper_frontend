// import 'dart:io';

import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

abstract class AdoptPetRepository {
  Future<void> createAdoptPet(AdoptPet adoptPet);
  Future<List<AdoptPet>> getAllAdoptPets();
  Future<AdoptPet> getAdoptPetById(String petId);
  // Future<AdoptPet> updateAdoptPet(AdoptPet adoptPet, File petImage);
  Future<String> deleteAdoptPet(String petId);
  Future<List<AdoptPet>> getAdoptPetsByOwnerId(String? ownerId);
  // Future<List<AdoptPet>> getAdoptPetsByNewOwnerId(String newOwnerId);
  // Future<List<AdoptPet>> getAdoptPetsByLocation(String location);
  // Future<List<AdoptPet>> getAdoptPetsByAdoptDate(String adoptDate);
  // Future<List<AdoptPet>> getAdoptPetsByStatus(String status);
}
