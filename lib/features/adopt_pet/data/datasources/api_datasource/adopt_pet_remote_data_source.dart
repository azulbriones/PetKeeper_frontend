import 'package:pet_keeper_front/features/adopt_pet/data/models/adopt_pet_model.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

abstract class AdoptPetRemoteDataSource {
  Future<void> createAdoptPet(AdoptPet adoptPet);
  Future<List<AdoptPetModel>> getAllAdoptPets();
  Future<AdoptPetModel> getAdoptPetById(String petId);
  Future<AdoptPetModel> updateAdoptPet(AdoptPet adoptPet);
  Future<void> updateStatusAdoptPet(String adoptPetId, String status);
  Future<void> deleteAdoptPet(String petId);
  Future<List<AdoptPetModel>> getAdoptPetsByOwnerId(String? ownerId);
  Future<List<AdoptPetModel>> getAdoptPetsByNewOwnerId(String newOwnerId);
  Future<List<AdoptPetModel>> getAdoptPetsByLocation(String location);
  Future<List<AdoptPetModel>> getAdoptPetsByAdoptDate(String adoptDate);
  Future<List<AdoptPetModel>> getAdoptPetsByStatus(String status);
}
