import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/forgot_password_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_in_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_up_usecase.dart';
part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  CredentialCubit(
      {required this.signUpUseCase,
      required this.signInUseCase,
      required this.forgotPasswordUseCase})
      : super(CredentialInitial());

  Future<void> forgotPassword({required String email}) async {
    try {
      await forgotPasswordUseCase.call(email);
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signInSubmit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(PetLoverEntity(
        email: email,
        password: password,
      ));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpSubmit({required PetLoverEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(user);

      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
