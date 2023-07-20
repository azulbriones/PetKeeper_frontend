part of 'adopt_pet_bloc.dart';

abstract class AdoptPetState {}

class LoadingAllPets extends AdoptPetState {}

class LoadedAllPets extends AdoptPetState {
  List<AdoptPet> allPets;

  LoadedAllPets({required this.allPets});
}

class InitialState extends AdoptPetState {}

class UpdatingPet extends AdoptPetState {}

class UpdatedPet extends AdoptPetState {
  final AdoptPet adoptPet;

  UpdatedPet({required this.adoptPet});
}

class LoadingDetailPet extends AdoptPetState {}

class LoadedDetailPet extends AdoptPetState {
  final AdoptPet adoptPet;
  LoadedDetailPet({required this.adoptPet});
}

class CreatingPet extends AdoptPetState {}

class CreatedPet extends AdoptPetState {
  List<AdoptPet> allPets;

  CreatedPet({required this.allPets});
}

class DeletePet extends AdoptPetState {
  final int petId;

  DeletePet({required this.petId});
}

class Error extends AdoptPetState {
  final String error;

  Error({required this.error});
}
