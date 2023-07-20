import 'dart:io';

class AdoptPet {
  final int? id;
  final String? petName;
  final File? petImage;
  final String? petBreed;
  final int? actualOwnerId;
  final String? actualOwnerName;
  final String? address;
  final int? age;
  final String? description;
  final String? status;
  final int? newOwnerId;
  final String? newOwnerName;
  final String? createdDate;

  AdoptPet({
    this.id,
    this.petName,
    this.petImage,
    this.petBreed,
    this.actualOwnerId,
    this.actualOwnerName,
    this.address,
    this.age,
    this.description,
    this.status,
    this.newOwnerId,
    this.newOwnerName,
    this.createdDate,
  });
}
