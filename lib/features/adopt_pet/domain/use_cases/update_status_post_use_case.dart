import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class UpdateStatusAdoptPetUseCase {
  final AdoptPetRepository adoptPetRepository;

  UpdateStatusAdoptPetUseCase(this.adoptPetRepository);
  Future<void> execute(String adoptPetId, String status) async {
    return await adoptPetRepository.updateStatusAdoptPet(adoptPetId, status);
  }
}
