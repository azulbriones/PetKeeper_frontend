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
  final String strayPetId;
  final String status;

  UpdatedStrayPet({required this.strayPetId, required this.status});
}

class LoadingDetailStrayPet extends StrayPetState {}

class LoadedDetailStrayPet extends StrayPetState {
  final StrayPet strayPet;
  LoadedDetailStrayPet({required this.strayPet});
}

class LoadingAllUserPostsStrayPet extends StrayPetState {}

class LoadedAllUserPostsStrayPet extends StrayPetState {
  List<StrayPet> allUserPostsStrayPets;
  LoadedAllUserPostsStrayPet({required this.allUserPostsStrayPets});
}

class CreatingStrayPet extends StrayPetState {}

class CreatedStrayPet extends StrayPetState {
  final StrayPet newStrayPet;

  CreatedStrayPet({required this.newStrayPet});
}

class DeletingStrayPet extends StrayPetState {}

class DeletedStrayPet extends StrayPetState {
  final String strayPetId;

  DeletedStrayPet({required this.strayPetId});
}

class StrayError extends StrayPetState {
  final String error;

  StrayError({required this.error});
}
