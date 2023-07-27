part of 'stray_pet_bloc.dart';

abstract class StrayPetEvent {}

class GetAllStrayPets extends StrayPetEvent {}

class CreateStrayPet extends StrayPetEvent {
  final StrayPet strayPet;

  CreateStrayPet({required this.strayPet});
}

class GetDetailStrayPet extends StrayPetEvent {
  final String? strayPetId;

  GetDetailStrayPet({required this.strayPetId});
}

class DeleteStrayPet extends StrayPetEvent {
  final String strayPetId;

  DeleteStrayPet({required this.strayPetId});
}

class UpdateStrayPet extends StrayPetEvent {
  final String strayPetId;
  final String status;

  UpdateStrayPet({required this.strayPetId, required this.status});
}

class GetAllUserPostsStrayPet extends StrayPetEvent {
  final String? userId;

  GetAllUserPostsStrayPet({required this.userId});
}
