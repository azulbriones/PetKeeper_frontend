import 'package:equatable/equatable.dart';

class FoundationEntity extends Equatable {
  final String? name;
  final String? email;
  final String? id;
  final String? profileUrl;
  final String? password;
  final String? type;

  const FoundationEntity(
      {this.name,
      this.email,
      this.id,
      this.profileUrl,
      this.password,
      this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        id,
        profileUrl,
        password,
        type,
      ];
}
