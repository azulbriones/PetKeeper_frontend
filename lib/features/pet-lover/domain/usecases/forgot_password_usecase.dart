import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class ForgotPasswordUseCase {
  final PetLoverRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
