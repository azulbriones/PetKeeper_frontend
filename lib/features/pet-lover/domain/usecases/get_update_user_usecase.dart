import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetUpdateUserUseCase {
  final PetLoverRepository repository;

  GetUpdateUserUseCase({required this.repository});
  Future<void> call(PetLoverEntity user) {
    return repository.getUpdateUser(user);
  }
}
