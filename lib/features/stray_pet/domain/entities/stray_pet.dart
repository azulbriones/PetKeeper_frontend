import 'dart:io';

class StrayPet {
  final int? id;
  final String? petName;
  final File? petImage;
  final String? petBreed;
  final int? ownerId;
  final String? ownerName;
  final String? address;
  final String? lostedDate;
  final int? reward;
  final int? age;
  final String? description;
  final String? status;
  final int? rescuerId;
  final String? rescuerName;
  final String? createdDate;

  StrayPet({
    this.id,
    this.petName,
    this.petImage,
    // this.age,
    this.petBreed,
    this.ownerId,
    this.ownerName,
    this.address,
    this.lostedDate,
    this.age,
    this.reward,
    this.description,
    this.status,
    this.rescuerId,
    this.rescuerName,
    this.createdDate,
  });
}

    // this.id,
    // required this.petName,
    // required this.petImage,
    // // this.age,
    // required this.petBreed,
    // required this.ownerId,
    // required this.ownerName,
    // required this.address,
    // required this.lostedDate,
    // this.age,
    // this.reward,
    // required this.description,
    // required this.status,
    // this.rescuerId,
    // this.rescuerName,
    // this.createdDate,