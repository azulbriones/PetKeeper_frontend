part of 'adopt_pet_bloc.dart';

abstract class AdoptPetEvent {}

class GetAllPets extends AdoptPetEvent {}

// class CreatePet extends AdoptPetEvent {
//   final dynamic id;
//   final String petName;
//   final dynamic petImage;
//   final String? petBreed;
//   final dynamic age;
//   final String description;
//   final String location;
//   final String address;
//   final String? ownerId;
//   final String? ownerName;

//   CreatePet({
//     this.id,
//     required this.petName,
//     required this.petImage,
//     this.petBreed,
//     this.ownerId,
//     this.ownerName,
//     required this.location,
//     required this.address,
//     this.age,
//     required this.description,
//   });
// }

class CreatePet extends AdoptPetEvent {
  final AdoptPet adoptPet;

  CreatePet({required this.adoptPet});
}

class GetDetailPet extends AdoptPetEvent {
  final String petId;

  GetDetailPet({required this.petId});
}

class GetAllUserPostsPet extends AdoptPetEvent {
  final String? userId;

  GetAllUserPostsPet({required this.userId});
}
