import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class DeleteAccountUseCase {
  final PetLoverRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<void> call() async {
    return repository.deleteAccount();
  }
}
