part of 'adopt_pet_bloc.dart';

abstract class AdoptPetEvent {}

class GetAllPets extends AdoptPetEvent {}

class CreatePet extends AdoptPetEvent {
  final AdoptPet adoptPet;

  CreatePet({required this.adoptPet});
}

class UpdateStatusPet extends AdoptPetEvent {
  final String adoptPetId;
  final String status;

  UpdateStatusPet({required this.adoptPetId, required this.status});
}

class GetDetailPet extends AdoptPetEvent {
  final String petId;

  GetDetailPet({required this.petId});
}

class DeletePet extends AdoptPetEvent {
  final String petId;

  DeletePet({required this.petId});
}

class GetAllUserPostsPet extends AdoptPetEvent {
  final String? userId;

  GetAllUserPostsPet({required this.userId});
}
