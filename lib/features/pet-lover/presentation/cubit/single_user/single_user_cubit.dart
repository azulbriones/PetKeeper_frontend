import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_single_user_usecase.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  SingleUserCubit({required this.getSingleUserUseCase})
      : super(SingleUserInitial());

  Future<void> getSingleUserProfile({required PetLoverEntity user}) async {
    emit(SingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(user);
      streamResponse.listen((user) {
        emit(SingleUserLoaded(currentUser: user.first));
      });
    } on SocketException catch (_) {
      emit(SingleUserFailure());
    } catch (_) {
      emit(SingleUserFailure());
    }
  }

  Future<void> singleUserDeleted() async {
    emit(SingleUserDeleted());
  }
}
