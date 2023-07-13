import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class DeleteStrayPetUseCase {
  final StrayPetRepository _repository;

  DeleteStrayPetUseCase(this._repository);

  Future<void> call(int id) {
    return _repository.deletePet(id);
  }
}
