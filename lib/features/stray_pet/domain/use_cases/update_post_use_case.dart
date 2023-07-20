import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class UpdatePostUseCase {
  final StrayPetRepository strayPetRepository;

  UpdatePostUseCase(this.strayPetRepository);
  Future<String> execute(StrayPet strayPet) async {
    return await strayPetRepository.updatePost(strayPet);
  }
}
