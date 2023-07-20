import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class GetPostDetailUseCase {
  final AdoptPetRepository adoptPetRepository;

  GetPostDetailUseCase(this.adoptPetRepository);
  Future<AdoptPet> execute(int postId) async {
    return await adoptPetRepository.getPostDetail(postId);
  }
}
