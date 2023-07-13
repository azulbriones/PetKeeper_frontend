import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_api_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class StrayPetRepositoryImpl implements StrayPetRepository {
  final StrayPetApiDataSource _apiDataSource;

  StrayPetRepositoryImpl(this._apiDataSource);

  @override
  Future<List<StrayPetModel>> getAllPets() {
    return _apiDataSource.getAllPets();
  }

  @override
  Future<StrayPetModel> getPetById(int id) {
    return _apiDataSource.getPetById(id);
  }

  @override
  Future<void> addNewPet(StrayPetModel strayPetModel) {
    return _apiDataSource.addNewPet(strayPetModel);
  }

  @override
  Future<void> deletePet(int id) {
    return _apiDataSource.deletePet(id);
  }

  @override
  Future<List<StrayPetModel>> getPetsByOwnerId(int ownerId) {
    return _apiDataSource.getPetsByOwnerId(ownerId);
  }

  @override
  Future<List<StrayPetModel>> getPetsByRescuerId(int rescuerId) {
    return _apiDataSource.getPetsByRescuerId(rescuerId);
  }

  @override
  Future<void> updatePet(int id, StrayPetModel pet) {
    return _apiDataSource.updatePet(id, pet);
  }
}
