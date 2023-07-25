import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetAllStrayPetsUseCase {
  final StrayPetRepository strayPetRepository;

  GetAllStrayPetsUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute() async {
    return await strayPetRepository.getAllStrayPets();
  }
}
