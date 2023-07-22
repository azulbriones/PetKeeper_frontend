import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetPostsByStatusUseCase {
  final StrayPetRepository strayPetRepository;

  GetPostsByStatusUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(String status) async {
    return await strayPetRepository.getPostsByStatus(status);
  }
}
