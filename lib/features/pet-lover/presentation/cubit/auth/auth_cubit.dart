import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/delete_account_usercase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_current_uid_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/is_sign_in_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/is_verified_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/send_verification_email_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_out_usecase.dart';
import 'package:pet_keeper_front/global/common/common.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final IsVerifiedUseCase isVerifiedUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentIdUseCase getCurrentUIDUseCase;
  final SendVerificationEmail sendVerificationEmail;
  final DeleteAccountUseCase deleteAccountUseCase;
  AuthCubit(
      {required this.isSignInUseCase,
      required this.isVerifiedUseCase,
      required this.signOutUseCase,
      required this.getCurrentUIDUseCase,
      required this.sendVerificationEmail,
      required this.deleteAccountUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isVerified = await isVerifiedUseCase.call();
      final isSignIn = await isSignInUseCase.call();

      if (isSignIn == true) {
        final uid = await getCurrentUIDUseCase.call();

        emit(Authenticated(uid: uid));
        if (isVerified == true) {
          final uid = await getCurrentUIDUseCase.call();

          emit(Verified(uid: uid));
        } else {
          if (isSignIn == true) {
            final uid = await getCurrentUIDUseCase.call();

            emit(Authenticated(uid: uid));
          } else {
            emit(UnAuthenticated());
          }
          emit(UnVerified());
        }
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
      emit(UnVerified());
    }
  }

  Future<void> loggedIn() async {
    final isVerified = await isVerifiedUseCase.call();
    try {
      final uid = await getCurrentUIDUseCase.call();

      emit(Authenticated(uid: uid));
      if (isVerified == true) {
        final uid = await getCurrentUIDUseCase.call();

        emit(Verified(uid: uid));
      } else {
        emit(UnVerified());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> sendVefEmail(email) async {
    await sendVerificationEmail.call(email);
  }

  Future<void> deleteAccount() async {
    try {
      emit(UnAuthenticated());
      emit(Deleted());
      await deleteAccountUseCase.call();
    } catch (e) {
      toast('Ha ocurrido un error al eliminar la cuenta: $e');
    }
  }
}
