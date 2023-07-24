import 'dart:io';

import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class UpdateStrayPetUseCase {
  final StrayPetRepository strayPetRepository;

  UpdateStrayPetUseCase(this.strayPetRepository);
  Future<StrayPet> execute(StrayPet strayPet, File petImage) async {
    return await strayPetRepository.updateStrayPet(strayPet, petImage);
  }
}
