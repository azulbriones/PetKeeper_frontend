import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetPostsByLostedDateUseCase {
  final StrayPetRepository strayPetRepository;

  GetPostsByLostedDateUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(String lostedDate) async {
    return await strayPetRepository.getPostsByLostedDate(lostedDate);
  }
}
