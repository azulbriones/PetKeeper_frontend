import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class ForgotPasswordUseCase {
  final FoundationRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
