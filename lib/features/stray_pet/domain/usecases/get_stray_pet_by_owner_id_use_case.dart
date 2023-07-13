import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetsByOwnerIdUseCase {
  final StrayPetRepository _repository;

  GetStrayPetsByOwnerIdUseCase(this._repository);

  Future<List<StrayPetModel>> call(int ownerId) {
    return _repository.getPetsByOwnerId(ownerId);
  }
}
