import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetCurrentIdUseCase {
  final PetLoverRepository repository;

  GetCurrentIdUseCase({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentId();
  }
}
