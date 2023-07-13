import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class IsSignInUseCase {
  final FoundationRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
