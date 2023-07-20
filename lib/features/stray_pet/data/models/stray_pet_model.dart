import 'dart:io';

import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

class StrayPetModel extends StrayPet {
  StrayPetModel(
      {int? id,
      String? petName,
      File? petImage,
      String? petBreed,
      int? ownerId,
      String? ownerName,
      String? address,
      String? lostedDate,
      int? reward,
      int? age,
      String? description,
      String? status,
      int? rescuerId,
      String? rescuerName,
      String? createdDate})
      : super(
          id: id,
          petName: petName,
          petImage: petImage,
          petBreed: petBreed,
          ownerId: ownerId,
          ownerName: ownerName,
          address: address,
          lostedDate: lostedDate,
          reward: reward,
          age: age,
          description: description,
          status: status,
          rescuerId: rescuerId,
          rescuerName: rescuerName,
          createdDate: createdDate,
        );

  factory StrayPetModel.fromJson(Map<String, dynamic> json) {
    return StrayPetModel(
        id: json['id'],
        petName: json['pet_name'],
        petImage: json['pet_image'],
        petBreed: json['pet_breed'],
        ownerId: json['owner_id'],
        ownerName: json['owner_name'],
        address: json['address'],
        lostedDate: json['losted_date'],
        reward: json['reward'],
        age: json['age'],
        description: json['description'],
        status: json['status'],
        rescuerId: json['rescuer_id'],
        rescuerName: json['rescuer_name'],
        createdDate: json['created_date']);
  }

  factory StrayPetModel.fromEntity(StrayPet strayPet) {
    return StrayPetModel(
        id: strayPet.id,
        petName: strayPet.petName,
        petImage: strayPet.petImage,
        petBreed: strayPet.petBreed,
        ownerId: strayPet.ownerId,
        ownerName: strayPet.ownerName,
        address: strayPet.address,
        lostedDate: strayPet.lostedDate,
        reward: strayPet.reward,
        age: strayPet.age,
        description: strayPet.description,
        status: strayPet.status,
        rescuerId: strayPet.rescuerId,
        rescuerName: strayPet.rescuerName,
        createdDate: strayPet.createdDate);
  }
}

// int? id,
//       required String petName,
//       required File petImage,
//       required String petBreed,
//       required int ownerId,
//       required String ownerName,
//       required String address,
//       required String lostedDate,
//       int? reward,
//       int? age,
//       required String description,
//       required String status,
//       int? rescuerId,
//       String? rescuerName,
//       String? createdDate
