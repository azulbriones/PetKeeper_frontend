class StrayPet {
  final dynamic id;
  final String petName;
  final dynamic petImage;
  final String? petBreed;
  final dynamic age;
  final String description;
  final String location;
  final String address;
  final String status;
  final dynamic reward;
  final String? rescuerId;
  final String? rescuerName;
  final String? ownerId;
  final String? ownerName;
  final dynamic lostDate;
  final dynamic createdAt;
  final dynamic payment;

  StrayPet({
    this.id,
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
    required this.status,
    this.rescuerId,
    this.rescuerName,
    this.createdAt,
    this.payment,
  });

  factory StrayPet.fromJson(Map<String, dynamic> json) {
    return StrayPet(
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
      payment: json['payment']
    );
  }

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
}
