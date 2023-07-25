part of 'foundation_cubit.dart';

abstract class FoundationState extends Equatable {
  const FoundationState();
}

class FoundationInitial extends FoundationState {
  @override
  List<Object?> get props => [];
}

class FoundationLoading extends FoundationState {
  @override
  List<Object?> get props => [];
}

class FoundationLoaded extends FoundationState {
  final List<PetLoverEntity> foundations;

  FoundationLoaded({required this.foundations});

  @override
  List<Object?> get props => [foundations];
}

class SingleFoundationLoading extends FoundationState {
  @override
  List<Object?> get props => [];
}

class SingleFoundationLoaded extends FoundationState {
  final PetLoverEntity foundation;

  SingleFoundationLoaded({required this.foundation});

  @override
  List<Object?> get props => [foundation];
}

class FoundationFailure extends FoundationState {
  @override
  List<Object?> get props => [];
}

class FoundationError extends FoundationState {
  final String error;

  FoundationError({required this.error});

  @override
  List<Object?> get props => [error];
}
