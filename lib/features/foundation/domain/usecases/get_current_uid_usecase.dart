import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetCurrentIdUseCase {
  final FoundationRepository repository;

  GetCurrentIdUseCase({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentId();
  }
}
