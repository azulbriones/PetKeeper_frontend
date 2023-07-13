import 'package:equatable/equatable.dart';

class StrayPetEntity extends Equatable {
  final int id;
  final String petName;
  final String? petImage;
  final int? age;
  final String? petBreed;
  final String info;
  final String address;
  final String status;
  final int? reward;
  final int? rescuerId;
  final int? ownerId;
  final String lostedDate;
  final String? createdAt;

  StrayPetEntity({
    required this.id,
    required this.petName,
    this.petImage,
    this.age,
    this.petBreed,
    required this.info,
    required this.address,
    required this.status,
    this.reward,
    this.rescuerId,
    this.ownerId,
    required this.lostedDate,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        petName,
        petImage,
        age,
        petBreed,
        info,
        address,
        status,
        reward,
        rescuerId,
        ownerId,
        lostedDate,
        createdAt,
      ];
}
