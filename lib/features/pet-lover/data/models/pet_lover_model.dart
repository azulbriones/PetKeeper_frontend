import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

class PetLoverModel extends PetLoverEntity {
  PetLoverModel({
    String? name,
    String? email,
    String? id,
    String? status,
    String? profileUrl,
  }) : super(
          name: name,
          email: email,
          id: id,
          profileUrl: profileUrl,
        );

  factory PetLoverModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snapshotMap = snapshot.data() as Map<String, dynamic>;

    return PetLoverModel(
        name: snapshotMap['name'],
        profileUrl: snapshotMap['profileUrl'],
        id: snapshotMap['id'],
        email: snapshotMap['email']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "id": id,
      "profileUrl": profileUrl,
    };
  }
}
