import 'package:flutter/material.dart';
import 'package:pet_keeper_front/RegisterPet.dart';
import 'package:pet_keeper_front/email_verify_user.dart';
import 'package:pet_keeper_front/login.dart';
import 'package:pet_keeper_front/register.dart';
import 'package:pet_keeper_front/splash_screen.dart';
import 'package:pet_keeper_front/stray_pets.dart';
import 'package:pet_keeper_front/toadopt_pets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PetKepper',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Login());
  }
}
