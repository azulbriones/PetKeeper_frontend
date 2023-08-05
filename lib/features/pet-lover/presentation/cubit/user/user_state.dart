part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<PetLoverEntity> users;

  const UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}

class ErrorUser extends UserState {
  final String error;

  const ErrorUser({required this.error});

  @override
  List<Object> get props => [];
}
