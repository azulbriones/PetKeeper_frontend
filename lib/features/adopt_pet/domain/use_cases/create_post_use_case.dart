import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class CreatePostUseCase {
  final AdoptPetRepository adoptPetRepository;

  CreatePostUseCase(this.adoptPetRepository);
  Future<List<AdoptPet>> execute(AdoptPet adoptPet) async {
    return await adoptPetRepository.createAdoptPet(adoptPet);
  }
}
