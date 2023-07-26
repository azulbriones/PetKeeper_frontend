import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

class AdoptPetModel extends AdoptPet {
  AdoptPetModel({
    dynamic id,
    required String petName,
    required dynamic petImage,
    String? petBreed,
    dynamic age,
    required String description,
    required String location,
    required String address,
    required String status,
    String? newOwnerId,
    String? newOwnerName,
    String? ownerId,
    String? ownerName,
    dynamic adoptDate,
    dynamic createdAt,
    dynamic payment,
  }) : super(
            id: id,
            petName: petName,
            petImage: petImage,
            petBreed: petBreed,
            ownerId: ownerId,
            ownerName: ownerName,
            address: address,
            location: location,
            adoptDate: adoptDate,
            age: age,
            description: description,
            status: status,
            newOwnerId: newOwnerId,
            newOwnerName: newOwnerName,
            createdAt: createdAt,
            payment: payment);

  factory AdoptPetModel.fromJson(Map<String, dynamic> json) {
    return AdoptPetModel(
      id: json['id'],
      petName: json['pet_name'],
      petImage: json['pet_image'],
      petBreed: json['pet_breed'],
      ownerId: json['owner_id'],
      ownerName: json['owner_name'],
      address: json['address'],
      location: json['location'],
      adoptDate: json['adopt_date'],
      age: json['age'],
      description: json['description'],
      status: json['status'],
      newOwnerId: json['new_owner_id'],
      newOwnerName: json['new_owner_name'],
      createdAt: json['createdAt'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_name': petName,
      'pet_image': petImage,
      'pet_breed': petBreed,
      'age': age,
      'description': description,
      'location': location,
      'address': address,
      'status': status,
      'new_owner_id': newOwnerId,
      'new_owner_name': newOwnerName,
      'owner_id': ownerId,
      'owner_name': ownerName,
      'adoptDate': adoptDate,
      'created_at': createdAt,
      'payment': payment
    };
  }

  factory AdoptPetModel.fromEntity(AdoptPet adoptPet) {
    return AdoptPetModel(
        id: adoptPet.id,
        petName: adoptPet.petName,
        petImage: adoptPet.petImage,
        petBreed: adoptPet.petBreed,
        ownerId: adoptPet.ownerId,
        ownerName: adoptPet.ownerName,
        address: adoptPet.address,
        location: adoptPet.location,
        adoptDate: adoptPet.adoptDate,
        age: adoptPet.age,
        description: adoptPet.description,
        status: adoptPet.status,
        newOwnerId: adoptPet.newOwnerId,
        newOwnerName: adoptPet.newOwnerName,
        createdAt: adoptPet.createdAt,
        payment: adoptPet.payment);
  }
}
