part of 'adopt_pet_bloc.dart';

abstract class AdoptPetEvent {}

class GetAllPets extends AdoptPetEvent {}

class CreatePet extends AdoptPetEvent {
  final int userid;
  final String username;
  final String description;
  final String date;

  CreatePet(
      {required this.userid,
      required this.username,
      required this.description,
      required this.date});
}

class GetDetailPet extends AdoptPetEvent {
  final String petId;

  GetDetailPet({required this.petId});
}
