import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class CreatePostUseCase {
  final StrayPetRepository strayPetRepository;

  CreatePostUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(StrayPet strayPet) async {
    return await strayPetRepository.createPost(strayPet);
  }
}
