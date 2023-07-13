import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class UpdateStrayPetUseCase {
  final StrayPetRepository _repository;

  UpdateStrayPetUseCase(this._repository);

  Future<void> call(int id, StrayPetModel pet) {
    return _repository.updatePet(id, pet);
  }
}
