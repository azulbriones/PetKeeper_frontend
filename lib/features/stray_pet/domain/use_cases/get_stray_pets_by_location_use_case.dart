import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetByLocationUseCase {
  final StrayPetRepository strayPetRepository;

  GetStrayPetByLocationUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(String address) async {
    return await strayPetRepository.getStrayPetsByLocation(address);
  }
}
