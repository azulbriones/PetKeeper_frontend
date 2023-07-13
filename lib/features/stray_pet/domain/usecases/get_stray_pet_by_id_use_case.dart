import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetByIdUseCase {
  final StrayPetRepository _repository;

  GetStrayPetByIdUseCase(this._repository);

  Future<StrayPetModel> call(int id) {
    return _repository.getPetById(id);
  }
}
