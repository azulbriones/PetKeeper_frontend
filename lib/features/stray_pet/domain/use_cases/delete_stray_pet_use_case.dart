import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class DeleteStrayPetUseCase {
  final StrayPetRepository strayPetRepository;

  DeleteStrayPetUseCase(this.strayPetRepository);
  Future<void> execute(String petId) async {
    return await strayPetRepository.deleteStrayPet(petId);
  }
}
