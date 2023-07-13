import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

class FoundationModel extends FoundationEntity {
  FoundationModel({
    String? name,
    String? email,
    String? id,
    String? status,
    String? profileUrl,
    String? type,
  }) : super(
          name: name,
          email: email,
          id: id,
          profileUrl: profileUrl,
          type: type,
        );

  factory FoundationModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snapshotMap = snapshot.data() as Map<String, dynamic>;

    return FoundationModel(
      name: snapshotMap['name'],
      profileUrl: snapshotMap['profileUrl'],
      id: snapshotMap['id'],
      email: snapshotMap['email'],
      type: snapshotMap['type'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "id": id,
      "profileUrl": profileUrl,
      "type": type,
    };
  }
}
