part of 'stray_pet_bloc.dart';

abstract class StrayPetEvent {}

class GetAllStrayPets extends StrayPetEvent {}

class CreateStrayPet extends StrayPetEvent {
  final int userid;
  final String username;
  final String description;
  final String date;

  CreateStrayPet(
      {required this.userid,
      required this.username,
      required this.description,
      required this.date});
}

class GetDetailStrayPet extends StrayPetEvent {
  final int strayPetId;

  GetDetailStrayPet({required this.strayPetId});
}
