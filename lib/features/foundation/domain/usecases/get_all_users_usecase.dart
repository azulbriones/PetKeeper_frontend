import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetAllUsersUseCase {
  final FoundationRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<FoundationEntity>> call(FoundationEntity user) {
    return repository.getAllUsers(user);
  }
}
