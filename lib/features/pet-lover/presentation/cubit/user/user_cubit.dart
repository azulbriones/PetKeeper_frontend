import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_all_users_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_update_user_usecase.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserCubit(
      {required this.getAllUsersUseCase, required this.getUpdateUserUseCase})
      : super(UserInitial());

  Future<void> getUsers({required PetLoverEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getAllUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> getUpdateUser({required PetLoverEntity user}) async {
    try {
      await getUpdateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
