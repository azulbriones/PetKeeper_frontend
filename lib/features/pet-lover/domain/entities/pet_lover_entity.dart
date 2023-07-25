import 'package:equatable/equatable.dart';

class PetLoverEntity extends Equatable {
  final String? name;
  final String? email;
  final String? id;
  final String? profileUrl;
  final String? password;
  final String? type;
  final dynamic certFile;
  final String? info;
  final String? payInfo;
  final String? address;
  final String? location;

  const PetLoverEntity({
    this.name,
    this.email,
    this.id,
    this.profileUrl,
    this.password,
    this.type,
    this.certFile,
    this.info,
    this.payInfo,
    this.address,
    this.location,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        id,
        profileUrl,
        password,
        type,
        certFile,
        info,
        payInfo,
        address,
        location,
      ];
}
