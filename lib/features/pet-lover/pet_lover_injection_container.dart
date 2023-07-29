import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource_impl.dart';
import 'package:pet_keeper_front/features/pet-lover/data/repositories/pet_lover_repository_impl.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/delete_account_usercase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/forgot_password_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_all_foundations_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_all_users_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_create_current_user_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_current_uid_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_single_foundation_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_single_user_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_update_user_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/is_sign_in_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/is_verified_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/send_verification_email_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_in_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_out_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/sign_up_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/credential/credential_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/foundation/foundation_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';

import '../injection_container.dart';

Future<void> petLoverInjectionContainer() async {
  //Cubit or Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSignInUseCase: sl.call(),
        isVerifiedUseCase: sl.call(),
        signOutUseCase: sl.call(),
        getCurrentUIDUseCase: sl.call(),
        sendVerificationEmail: sl.call(),
        deleteAccountUseCase: sl.call(),
      ));

  sl.registerFactory<SingleUserCubit>(
      () => SingleUserCubit(getSingleUserUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
        getAllUsersUseCase: sl.call(),
        getUpdateUserUseCase: sl.call(),
      ));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      forgotPasswordUseCase: sl.call(),
      signInUseCase: sl.call(),
      signUpUseCase: sl.call()));

  sl.registerFactory<FoundationCubit>(
    () => FoundationCubit(
      getAllFoundationsUseCase: sl.call(),
      getSingleFoundationUsecase: sl.call(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllFoundationsUseCase>(
      () => GetAllFoundationsUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSingleFoundationUsecase>(
      () => GetSingleFoundationUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentIdUseCase>(
      () => GetCurrentIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSingleUserUseCase>(
      () => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsVerifiedUseCase>(
      () => IsVerifiedUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendVerificationEmail>(
      () => SendVerificationEmail(repository: sl.call()));
  sl.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(repository: sl.call()));

  //Repository
  sl.registerLazySingleton<PetLoverRepository>(
      () => PetLoverRepositoryImpl(remoteDataSource: sl.call()));

  // RemoteDataSource

  sl.registerLazySingleton<PetLoverFirebaseDataSource>(() =>
      PetLoverFirebaseDataSourceImpl(firestore: sl.call(), auth: sl.call()));
}
