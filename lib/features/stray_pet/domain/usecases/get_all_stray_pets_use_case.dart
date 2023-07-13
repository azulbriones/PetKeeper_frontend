import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetAllSrayPetsUseCase {
  final StrayPetRepository _repository;

  GetAllSrayPetsUseCase(this._repository);

  Future<List<StrayPetModel>> call() {
    return _repository.getAllPets();
  }
}
