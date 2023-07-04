import 'package:equatable/equatable.dart';

class PetLoverEntity extends Equatable {
  final String? name;
  final String? email;
  final String? id;
  final String? profileUrl;
  final String? password;

  const PetLoverEntity(
      {this.name, this.email, this.id, this.profileUrl, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        id,
        profileUrl,
        password,
      ];
}
