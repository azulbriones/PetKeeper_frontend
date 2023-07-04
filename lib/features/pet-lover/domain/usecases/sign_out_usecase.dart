import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class SignOutUseCase {
  final PetLoverRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
