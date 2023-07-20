import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class GetPostsByAddressUseCase {
  final AdoptPetRepository adoptPetRepository;

  GetPostsByAddressUseCase(this.adoptPetRepository);
  Future<List<AdoptPet>> execute(String address) async {
    return await adoptPetRepository.getPostsByAddress(address);
  }
}
