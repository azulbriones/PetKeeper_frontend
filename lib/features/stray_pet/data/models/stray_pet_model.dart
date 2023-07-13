import 'package:equatable/equatable.dart';

class StrayPetModel extends Equatable {
  final int? id;
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

  StrayPetModel({
    this.id,
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

  factory StrayPetModel.fromJson(Map<String, dynamic> json) {
    return StrayPetModel(
      id: json['id'],
      petName: json['pet_name'],
      petImage: json['pet_image'],
      age: json['age'],
      petBreed: json['pet_breed'],
      info: json['info'],
      address: json['address'],
      status: json['status'],
      reward: json['reward'],
      rescuerId: json['rescuer_id'],
      ownerId: json['owner_id'],
      lostedDate: json['losted_date'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_name': petName,
      'pet_image': petImage,
      'age': age,
      'pet_breed': petBreed,
      'info': info,
      'address': address,
      'status': status,
      'reward': reward,
      'rescuer_id': rescuerId,
      'owner_id': ownerId,
      'losted_date': lostedDate,
      'created_at': createdAt,
    };
  }

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
