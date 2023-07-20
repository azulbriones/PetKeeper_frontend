import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetPostsByRescuerIdUseCase {
  final StrayPetRepository strayPetRepository;

  GetPostsByRescuerIdUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(int rescuerId) async {
    return await strayPetRepository.getPostByRescuerId(rescuerId);
  }
}
