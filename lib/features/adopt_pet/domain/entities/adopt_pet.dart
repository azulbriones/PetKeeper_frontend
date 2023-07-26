class AdoptPet {
  final dynamic id;
  final String petName;
  final dynamic petImage;
  final String? petBreed;
  final dynamic age;
  final String description;
  final String location;
  final String address;
  final String status;
  final String? newOwnerId;
  final String? newOwnerName;
  final String? ownerId;
  final String? ownerName;
  final dynamic adoptDate;
  final dynamic createdAt;
  final dynamic payment;

  AdoptPet({
    this.id,
    required this.petName,
    required this.petImage,
    this.petBreed,
    this.ownerId,
    this.ownerName,
    required this.location,
    required this.address,
    this.adoptDate,
    this.age,
    required this.description,
    required this.status,
    this.newOwnerId,
    this.newOwnerName,
    this.createdAt,
    this.payment,
  });

  factory AdoptPet.fromJson(Map<String, dynamic> json) {
    return AdoptPet(
        id: json['id'],
        petName: json['pet_name'],
        petImage: json['pet_image'],
        petBreed: json['pet_breed'],
        ownerId: json['owner_id'],
        ownerName: json['owner_name'],
        address: json['address'],
        location: json['location'],
        adoptDate: json['adoptDate'],
        age: json['age'],
        description: json['description'],
        status: json['status'],
        newOwnerId: json['new_owner_id'],
        newOwnerName: json['new_owner_name'],
        createdAt: json['createdAt'],
        payment: json['payment']);
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
      'new_owner_id': newOwnerId,
      'new_owner_name': newOwnerName,
      'owner_id': ownerId,
      'owner_name': ownerName,
      'adopt_date': adoptDate,
      'created_at': createdAt,
      'payment': payment
    };
  }
}
