import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetByIdUseCase {
  final StrayPetRepository strayPetRepository;

  GetStrayPetByIdUseCase(this.strayPetRepository);
  Future<StrayPet> execute(String petId) async {
    return await strayPetRepository.getStrayPetById(petId);
  }
}
