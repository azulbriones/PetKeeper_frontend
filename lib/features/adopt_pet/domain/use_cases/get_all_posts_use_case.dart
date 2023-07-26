import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class GetAllPostsUseCase {
  final AdoptPetRepository adoptPetRepository;

  GetAllPostsUseCase(this.adoptPetRepository);
  Future<List<AdoptPet>> execute() async {
    return await adoptPetRepository.getAllAdoptPets();
  }
}
