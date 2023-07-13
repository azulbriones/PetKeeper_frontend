import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class SignInUseCase {
  final FoundationRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(FoundationEntity user) {
    return repository.signIn(user);
  }
}
