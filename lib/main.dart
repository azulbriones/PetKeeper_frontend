import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/credential/credential_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/login_page.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/bloc/stray_pet_bloc.dart';
import 'package:pet_keeper_front/global/pages/main_layout.dart';
import 'package:pet_keeper_front/on_generate_route.dart';
import 'package:pet_keeper_front/use_case_config.dart';
import 'features/injection_container.dart' as di;

UseCaseConfig usecaseConfig = UseCaseConfig();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  final authCubit = di.sl<AuthCubit>();
  await authCubit.appStarted();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider<SingleUserCubit>(create: (_) => di.sl<SingleUserCubit>()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<StrayPetBloc>(
          create: (BuildContext context) => StrayPetBloc(
            createPostUseCase: usecaseConfig.createPostUseCase!,
            deletePostUseCase: usecaseConfig.deletePostUseCase!,
            getAllPostsUseCase: usecaseConfig.getAllPostsUseCase!,
            getPostDetailUseCase: usecaseConfig.getPostDetailUseCase!,
            getPostsByAddressUseCase: usecaseConfig.getPostsByAddressUseCase!,
            getPostsByLostedDateUseCase:
                usecaseConfig.getPostsByLostedDateUseCase!,
            getPostsByOwnerIdUseCase: usecaseConfig.getPostsByOwnerIdUseCase!,
            getPostsByRescuerIdUseCase:
                usecaseConfig.getPostsByRescuerIdUseCase!,
            getPostsByStatusUseCase: usecaseConfig.getPostsByStatusUseCase!,
            updatePostUseCase: usecaseConfig.updatePostUseCase!,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'PetKeeper',
        onGenerateRoute: OnGenerateRoute.route,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        theme: ThemeData(primarySwatch: Colors.indigo),
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainLayout(uid: authState.uid);
                } else {
                  return const LoginPage();
                }
              },
            );
          },
        },
      ),
    );
  }
}
