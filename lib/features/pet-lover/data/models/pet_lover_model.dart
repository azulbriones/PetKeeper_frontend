import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

class PetLoverModel extends PetLoverEntity {
  PetLoverModel({
    String? name,
    String? email,
    String? id,
    String? status,
    String? profileUrl,
    String? type,
    dynamic certFile,
    String? info,
    String? payInfo,
    String? address,
    String? location,
  }) : super(
          name: name,
          email: email,
          id: id,
          profileUrl: profileUrl,
          type: type,
          certFile: certFile,
          info: info,
          payInfo: payInfo,
          address: address,
          location: location,
        );

  factory PetLoverModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snapshotMap = snapshot.data() as Map<String, dynamic>;

    return PetLoverModel(
      name: snapshotMap['name'],
      profileUrl: snapshotMap['profileUrl'],
      id: snapshotMap['id'],
      email: snapshotMap['email'],
      type: snapshotMap['type'],
      certFile: snapshotMap['certFile'],
      info: snapshotMap['info'],
      payInfo: snapshotMap['payInfo'],
      address: snapshotMap['address'],
      location: snapshotMap['location'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "id": id,
      "profileUrl": profileUrl,
      "type": type,
      "certFile": certFile,
      "info": info,
      "payInfo": payInfo,
      "address": address,
      "location": location,
    };
  }
}
