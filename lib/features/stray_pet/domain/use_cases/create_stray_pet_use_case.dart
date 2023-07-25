import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class CreateStrayPetUseCase {
  final StrayPetRepository strayPetRepository;

  CreateStrayPetUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(StrayPet strayPet) async {
    print("usecase");
    return await strayPetRepository.createStrayPet(strayPet);
  }
}
