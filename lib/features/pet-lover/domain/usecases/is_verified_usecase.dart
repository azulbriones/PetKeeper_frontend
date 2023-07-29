import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class IsVerifiedUseCase {
  final PetLoverRepository repository;

  IsVerifiedUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isVerified();
  }
}
