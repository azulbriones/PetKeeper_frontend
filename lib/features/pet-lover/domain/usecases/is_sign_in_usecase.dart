import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class IsSignInUseCase {
  final PetLoverRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
