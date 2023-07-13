import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/adopt-pet/presentation/pages/toadopt_pets.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/credential/credential_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/login_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_pets.dart';
import 'package:pet_keeper_front/global/pages/home_page.dart';
import 'package:pet_keeper_front/global/pages/main_layout.dart';
import 'package:pet_keeper_front/on_generate_route.dart';
import 'features/injection_container.dart' as di;

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
