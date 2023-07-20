import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetPostDetailUseCase {
  final StrayPetRepository strayPetRepository;

  GetPostDetailUseCase(this.strayPetRepository);
  Future<StrayPet> execute(int postId) async {
    return await strayPetRepository.getPostDetail(postId);
  }
}
