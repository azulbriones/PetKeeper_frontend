import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class SignUpUseCase {
  final PetLoverRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(PetLoverEntity user) {
    return repository.signUp(user);
  }
}
