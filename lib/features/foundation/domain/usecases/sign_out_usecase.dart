import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class SignOutUseCase {
  final FoundationRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
