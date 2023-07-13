import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class AddNewStrayPetUseCase {
  final StrayPetRepository _repository;

  AddNewStrayPetUseCase(this._repository);

  Future<void> call(StrayPetModel pet) {
    return _repository.addNewPet(pet);
  }
}
