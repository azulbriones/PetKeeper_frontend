import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

class StrayPetModel extends StrayPet {
  StrayPetModel({
    dynamic id,
    required String petName,
    required dynamic petImage,
    String? petBreed,
    dynamic age,
    required String description,
    required String location,
    required String address,
    required String status,
    dynamic reward,
    String? rescuerId,
    String? rescuerName,
    String? ownerId,
    String? ownerName,
    required dynamic lostDate,
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
            lostDate: lostDate,
            reward: reward,
            age: age,
            description: description,
            status: status,
            rescuerId: rescuerId,
            rescuerName: rescuerName,
            createdAt: createdAt,
            payment: payment);

  factory StrayPetModel.fromJson(Map<String, dynamic> json) {
    return StrayPetModel(
      id: json['id'],
      petName: json['pet_name'],
      petImage: json['pet_image'],
      petBreed: json['pet_breed'],
      ownerId: json['owner_id'],
      ownerName: json['owner_name'],
      address: json['address'],
      location: json['location'],
      lostDate: json['lost_date'],
      reward: json['reward'],
      age: json['age'],
      description: json['description'],
      status: json['status'],
      rescuerId: json['rescuer_id'],
      rescuerName: json['rescuer_name'],
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
      'reward': reward,
      'rescuer_id': rescuerId,
      'rescuer_name': rescuerName,
      'owner_id': ownerId,
      'owner_name': ownerName,
      'lost_date': lostDate,
      'created_at': createdAt,
      'payment': payment
    };
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
        location: strayPet.location,
        lostDate: strayPet.lostDate,
        reward: strayPet.reward,
        age: strayPet.age,
        description: strayPet.description,
        status: strayPet.status,
        rescuerId: strayPet.rescuerId,
        rescuerName: strayPet.rescuerName,
        createdAt: strayPet.createdAt,
        payment: strayPet.payment);
  }
}
