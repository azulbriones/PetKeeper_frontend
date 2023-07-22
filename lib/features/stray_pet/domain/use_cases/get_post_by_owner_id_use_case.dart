import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetPostsByOwnerIdUseCase {
  final StrayPetRepository strayPetRepository;

  GetPostsByOwnerIdUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(int ownerId) async {
    return await strayPetRepository.getPostByOwnerId(ownerId);
  }
}
