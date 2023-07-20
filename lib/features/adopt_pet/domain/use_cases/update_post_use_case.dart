import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class UpdatePostUseCase {
  final AdoptPetRepository adoptPetRepository;

  UpdatePostUseCase(this.adoptPetRepository);
  Future<String> execute(AdoptPet adoptPet) async {
    return await adoptPetRepository.updatePost(adoptPet);
  }
}
