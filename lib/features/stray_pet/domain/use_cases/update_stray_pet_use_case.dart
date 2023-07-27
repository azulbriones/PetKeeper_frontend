import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class UpdateStrayPetUseCase {
  final StrayPetRepository strayPetRepository;

  UpdateStrayPetUseCase(this.strayPetRepository);
  Future<void> execute(String strayPetId, String status) async {
    return await strayPetRepository.updateStrayPet(strayPetId, status);
  }
}
