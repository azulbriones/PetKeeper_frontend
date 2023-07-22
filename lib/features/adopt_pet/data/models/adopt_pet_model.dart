import 'dart:io';

import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

class AdoptPetModel extends AdoptPet {
  AdoptPetModel(
      {int? id,
      String? petName,
      File? petImage,
      String? petBreed,
      int? actualOwnerId,
      String? actualOwnerName,
      String? address,
      int? age,
      String? description,
      String? status,
      int? newOwnerId,
      String? newOwnerName,
      String? createdDate})
      : super(
          id: id,
          petName: petName,
          petImage: petImage,
          petBreed: petBreed,
          actualOwnerId: actualOwnerId,
          actualOwnerName: actualOwnerName,
          address: address,
          age: age,
          description: description,
          status: status,
          newOwnerId: newOwnerId,
          newOwnerName: newOwnerName,
          createdDate: createdDate,
        );

  factory AdoptPetModel.fromJson(Map<String, dynamic> json) {
    return AdoptPetModel(
        id: json['id'],
        petName: json['pet_name'],
        petImage: json['pet_image'],
        petBreed: json['pet_breed'],
        actualOwnerId: json['actualOwnerId'],
        actualOwnerName: json['actualOwnerName'],
        address: json['address'],
        age: json['age'],
        description: json['description'],
        status: json['status'],
        newOwnerId: json['newOwnerId'],
        newOwnerName: json['newOwnerName'],
        createdDate: json['created_date']);
  }

  factory AdoptPetModel.fromEntity(AdoptPet adoptPet) {
    return AdoptPetModel(
        id: adoptPet.id,
        petName: adoptPet.petName,
        petImage: adoptPet.petImage,
        petBreed: adoptPet.petBreed,
        actualOwnerId: adoptPet.actualOwnerId,
        actualOwnerName: adoptPet.actualOwnerName,
        address: adoptPet.address,
        age: adoptPet.age,
        description: adoptPet.description,
        status: adoptPet.status,
        newOwnerId: adoptPet.newOwnerId,
        newOwnerName: adoptPet.newOwnerName,
        createdDate: adoptPet.createdDate);
  }
}
