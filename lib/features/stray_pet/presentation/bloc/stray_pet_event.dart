part of 'stray_pet_bloc.dart';

abstract class StrayPetEvent {}

class GetAllStrayPets extends StrayPetEvent {}

class CreateStrayPet extends StrayPetEvent {
  final String petName;
  final dynamic petImage;
  final String? petBreed;
  final dynamic age;
  final String description;
  final String location;
  final String address;
  final dynamic reward;
  final String? ownerId;
  final String? ownerName;
  final dynamic lostDate;

  CreateStrayPet({
    required this.petName,
    required this.petImage,
    this.petBreed,
    this.ownerId,
    this.ownerName,
    required this.location,
    required this.address,
    required this.lostDate,
    this.age,
    this.reward,
    required this.description,
  });
}

class GetDetailStrayPet extends StrayPetEvent {
  final String? strayPetId;

  GetDetailStrayPet({required this.strayPetId});
}

class GetAllUserPostsStrayPet extends StrayPetEvent {
  final String? userId;

  GetAllUserPostsStrayPet({required this.userId});
}
