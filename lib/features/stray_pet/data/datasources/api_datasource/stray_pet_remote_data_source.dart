import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

abstract class StrayPetRemoteDataSource {
  Future<void> createStrayPet(StrayPet strayPet);
  Future<List<StrayPetModel>> getAllStrayPets();
  Future<StrayPetModel> getStrayPetById(String petId);
  Future<void> updateStrayPet(String strayPetId, String status);
  Future<void> deleteStrayPet(String petId);
  Future<List<StrayPetModel>> getStrayPetsByOwnerId(String? ownerId);
  Future<List<StrayPetModel>> getStrayPetsByRescuerId(String rescuerId);
  Future<List<StrayPetModel>> getStrayPetsByLocation(String location);
  Future<List<StrayPetModel>> getStrayPetsByLostDate(String lostDate);
  Future<List<StrayPetModel>> getStrayPetsByStatus(String status);
}
