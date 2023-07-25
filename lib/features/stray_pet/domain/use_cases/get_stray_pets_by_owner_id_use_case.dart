import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class GetStrayPetsByOwnerIdUseCase {
  final StrayPetRepository strayPetRepository;

  GetStrayPetsByOwnerIdUseCase(this.strayPetRepository);
  Future<List<StrayPet>> execute(String ownerId) async {
    return await strayPetRepository.getStrayPetsByOwnerId(ownerId);
  }
}
