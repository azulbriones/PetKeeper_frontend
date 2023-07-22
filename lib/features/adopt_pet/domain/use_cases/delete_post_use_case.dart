import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class DeletePostUseCase {
  final AdoptPetRepository adoptPetRepository;

  DeletePostUseCase(this.adoptPetRepository);
  Future<String> execute(int postId) async {
    return await adoptPetRepository.deletePost(postId);
  }
}
