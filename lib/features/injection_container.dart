import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_keeper_front/features/pet-lover/pet_lover_injection_container.dart';
import 'package:pet_keeper_front/features/storage/storage_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => storage);

  await petLoverInjectionContainer();
  await storageInjectionContainer();
}
