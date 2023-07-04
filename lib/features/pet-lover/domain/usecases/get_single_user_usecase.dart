import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetSingleUserUseCase {
  final PetLoverRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<PetLoverEntity>> call(PetLoverEntity user) {
    return repository.getSingleUser(user);
  }
}
