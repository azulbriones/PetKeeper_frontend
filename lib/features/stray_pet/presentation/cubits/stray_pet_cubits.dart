import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet_entity.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/add_new_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/delete_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/get_all_stray_pets_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/get_stray_pet_by_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/get_stray_pet_by_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/get_stray_pets_by_rescuer_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/usecases/update_stray_pet_use_case.dart';

part 'stray_pet_states.dart';

class GetAllPetsCubit extends Cubit<StrayPetState> {
  final GetAllSrayPetsUseCase _useCase;

  GetAllPetsCubit(this._useCase) : super(GetAllPetsInitial());

  Future<void> getAllPets() async {
    try {
      emit(GetAllPetsLoading());
      final pets = await _useCase.call();
      emit(GetAllPetsLoaded(pets));
    } catch (e) {
      emit(GetAllPetsError(e.toString()));
    }
  }
}

class GetPetByIdCubit extends Cubit<StrayPetState> {
  final GetStrayPetByIdUseCase _useCase;

  GetPetByIdCubit(this._useCase) : super(GetPetByIdInitial());

  Future<void> getPetById(int id) async {
    try {
      emit(GetPetByIdLoading());
      final pet = await _useCase.call(id);
      emit(GetPetByIdLoaded(pet));
    } catch (e) {
      emit(GetPetByIdError(e.toString()));
    }
  }
}

class AddNewPetCubit extends Cubit<StrayPetState> {
  final AddNewStrayPetUseCase _useCase;

  AddNewPetCubit(this._useCase) : super(AddNewPetInitial());

  Future<void> addNewPet(StrayPetModel pet) async {
    try {
      emit(AddNewPetLoading());
      await _useCase.call(pet);
      emit(AddNewPetSuccess());
    } catch (e) {
      emit(AddNewPetError(e.toString()));
    }
  }
}

class DeletePetCubit extends Cubit<StrayPetState> {
  final DeleteStrayPetUseCase _useCase;

  DeletePetCubit(this._useCase) : super(DeletePetInitial());

  Future<void> deletePet(int id) async {
    try {
      emit(DeletePetLoading());
      await _useCase.call(id);
      emit(DeletePetSuccess());
    } catch (e) {
      emit(DeletePetError(e.toString()));
    }
  }
}

class GetPetsByOwnerIdCubit extends Cubit<StrayPetState> {
  final GetStrayPetsByOwnerIdUseCase _useCase;

  GetPetsByOwnerIdCubit(this._useCase) : super(GetPetsByOwnerIdInitial());

  Future<void> getPetsByOwnerId(int ownerId) async {
    try {
      emit(GetPetsByOwnerIdLoading());
      final pets = await _useCase.call(ownerId);
      emit(GetPetsByOwnerIdLoaded(pets));
    } catch (e) {
      emit(GetPetsByOwnerIdError(e.toString()));
    }
  }
}

class GetPetsByRescuerIdCubit extends Cubit<StrayPetState> {
  final GetStrayPetsByRescuerIdUseCase _useCase;

  GetPetsByRescuerIdCubit(this._useCase) : super(GetPetsByRescuerIdInitial());

  Future<void> getPetsByRescuerId(int rescuerId) async {
    try {
      emit(GetPetsByRescuerIdLoading());
      final pets = await _useCase.call(rescuerId);
      emit(GetPetsByRescuerIdLoaded(pets));
    } catch (e) {
      emit(GetPetsByRescuerIdError(e.toString()));
    }
  }
}

class UpdatePetCubit extends Cubit<StrayPetState> {
  final UpdateStrayPetUseCase _useCase;

  UpdatePetCubit(this._useCase) : super(UpdatePetInitial());

  Future<void> updatePet(int id, StrayPetModel pet) async {
    try {
      emit(UpdatePetLoading());
      await _useCase.call(id, pet);
      emit(UpdatePetSuccess());
    } catch (e) {
      emit(UpdatePetError(e.toString()));
    }
  }
}
