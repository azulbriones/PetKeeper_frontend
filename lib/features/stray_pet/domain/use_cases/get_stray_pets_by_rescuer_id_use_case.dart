import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetsByRescuerIdUseCase {
  final StrayPetRepository strayPetRepository;

  GetStrayPetsByRescuerIdUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(String rescuerId) async {
    return await strayPetRepository.getStrayPetsByRescuerId(rescuerId);
  }
}
