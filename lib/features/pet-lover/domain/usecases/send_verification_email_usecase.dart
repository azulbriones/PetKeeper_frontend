import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class SendVerificationEmail {
  final PetLoverRepository repository;

  SendVerificationEmail({required this.repository});

  Future<void> call(String email) {
    return repository.sendVerificationEmail(email);
  }
}
