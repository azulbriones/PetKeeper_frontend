import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';

class GetPostByActualOwnerIdUseCase {
  final AdoptPetRepository adoptPetRepository;

  GetPostByActualOwnerIdUseCase(this.adoptPetRepository);
  Future<List<AdoptPet>> execute(int actualOwnerId) async {
    return await adoptPetRepository.getPostByActualOwnerId(actualOwnerId);
  }
}
