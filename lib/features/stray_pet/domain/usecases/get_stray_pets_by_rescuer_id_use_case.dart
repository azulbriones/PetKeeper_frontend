import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetsByRescuerIdUseCase {
  final StrayPetRepository _repository;

  GetStrayPetsByRescuerIdUseCase(this._repository);

  Future<List<StrayPetModel>> call(int rescuerId) {
    return _repository.getPetsByRescuerId(rescuerId);
  }
}
