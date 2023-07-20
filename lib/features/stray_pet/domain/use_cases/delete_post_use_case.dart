import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class DeletePostUseCase {
  final StrayPetRepository strayPetRepository;

  DeletePostUseCase(this.strayPetRepository);
  Future<String> execute(int postId) async {
    return await strayPetRepository.deletePost(postId);
  }
}
