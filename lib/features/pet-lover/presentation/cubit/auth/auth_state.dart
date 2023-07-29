part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});

  @override
  List<Object> get props => [uid];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class Deleted extends AuthState {
  @override
  List<Object> get props => [];
}

class UnVerified extends AuthState {
  @override
  List<Object> get props => [];
}

class Verified extends AuthState {
  final String uid;

  const Verified({required this.uid});

  @override
  List<Object> get props => [uid];
}
