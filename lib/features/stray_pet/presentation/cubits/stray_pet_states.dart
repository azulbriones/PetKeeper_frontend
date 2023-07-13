part of 'stray_pet_cubits.dart';

abstract class StrayPetState {}

class GetAllPetsInitial extends StrayPetState {}

class GetAllPetsLoading extends StrayPetState {}

class GetAllPetsLoaded extends StrayPetState {
  final List<StrayPetModel> pets;

  GetAllPetsLoaded(this.pets);
}

class GetAllPetsError extends StrayPetState {
  final String message;

  GetAllPetsError(this.message);
}

class GetPetByIdInitial extends StrayPetState {}

class GetPetByIdLoading extends StrayPetState {}

class GetPetByIdLoaded extends StrayPetState {
  final StrayPetModel pet;

  GetPetByIdLoaded(this.pet);
}

class GetPetByIdError extends StrayPetState {
  final String message;

  GetPetByIdError(this.message);
}

class AddNewPetInitial extends StrayPetState {}

class AddNewPetLoading extends StrayPetState {}

class AddNewPetSuccess extends StrayPetState {}

class AddNewPetError extends StrayPetState {
  final String message;

  AddNewPetError(this.message);
}

class DeletePetInitial extends StrayPetState {}

class DeletePetLoading extends StrayPetState {}

class DeletePetSuccess extends StrayPetState {}

class DeletePetError extends StrayPetState {
  final String message;

  DeletePetError(this.message);
}

class GetPetsByOwnerIdInitial extends StrayPetState {}

class GetPetsByOwnerIdLoading extends StrayPetState {}

class GetPetsByOwnerIdLoaded extends StrayPetState {
  final List<StrayPetModel> pets;

  GetPetsByOwnerIdLoaded(this.pets);
}

class GetPetsByOwnerIdError extends StrayPetState {
  final String message;

  GetPetsByOwnerIdError(this.message);
}

class GetPetsByRescuerIdInitial extends StrayPetState {}

class GetPetsByRescuerIdLoading extends StrayPetState {}

class GetPetsByRescuerIdLoaded extends StrayPetState {
  final List<StrayPetModel> pets;

  GetPetsByRescuerIdLoaded(this.pets);
}

class GetPetsByRescuerIdError extends StrayPetState {
  final String message;

  GetPetsByRescuerIdError(this.message);
}

class UpdatePetInitial extends StrayPetState {}

class UpdatePetLoading extends StrayPetState {}

class UpdatePetSuccess extends StrayPetState {}

class UpdatePetError extends StrayPetState {
  final String message;

  UpdatePetError(this.message);
}
