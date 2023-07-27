import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class CreateStrayPetUseCase {
  final StrayPetRepository strayPetRepository;

  CreateStrayPetUseCase(this.strayPetRepository);
  Future<void> execute(StrayPet strayPet) async {
    return await strayPetRepository.createStrayPet(strayPet);
  }
}
