import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class GetSingleFoundationUsecase {
  final PetLoverRepository repository;

  GetSingleFoundationUsecase({required this.repository});
  Future<PetLoverEntity> execute(String petId) async {
    return await repository.getSingleFoundation(petId);
  }
}
