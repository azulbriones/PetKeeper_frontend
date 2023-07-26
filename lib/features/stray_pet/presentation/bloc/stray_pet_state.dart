part of 'stray_pet_bloc.dart';

abstract class StrayPetState {}

class LoadingAllStrayPets extends StrayPetState {}

class LoadedAllStrayPets extends StrayPetState {
  List<StrayPet> allStrayPets;

  LoadedAllStrayPets({required this.allStrayPets});
}

class InitialState extends StrayPetState {}

class UpdatingStrayPet extends StrayPetState {}

class UpdatedStrayPet extends StrayPetState {
  final StrayPet strayPet;

  UpdatedStrayPet({required this.strayPet});
}

class LoadingDetailStrayPet extends StrayPetState {}

class LoadedDetailStrayPet extends StrayPetState {
  final StrayPet strayPet;
  LoadedDetailStrayPet({required this.strayPet});
}

class CreatingStrayPet extends StrayPetState {}

class CreatedStrayPet extends StrayPetState {
  List<StrayPet> allStrayPets;

  CreatedStrayPet({required this.allStrayPets});
}

class DeleteStrayPet extends StrayPetState {
  final String strayPetId;

  DeleteStrayPet({required this.strayPetId});
}

class StrayError extends StrayPetState {
  final String error;

  StrayError({required this.error});
}
