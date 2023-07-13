import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';

abstract class StrayPetApiDataSource {
  Future<List<StrayPetModel>> getAllPets();
  Future<StrayPetModel> getPetById(int id);
  Future<void> addNewPet(StrayPetModel strayPetModel);
  Future<void> deletePet(int id);
  Future<List<StrayPetModel>> getPetsByOwnerId(int ownerId);
  Future<List<StrayPetModel>> getPetsByRescuerId(int rescuerId);
  Future<void> updatePet(int id, StrayPetModel pet);
}
