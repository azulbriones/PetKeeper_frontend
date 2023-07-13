import 'package:pet_keeper_front/features/foundation/data/datasources/firebase_datasource/foundation_firebase_datasource.dart';
import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/foundation/domain/repositories/foundation_repository.dart';
import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class FoundationRepositoryImpl implements FoundationRepository {
  final FoundationFirebaseDataSource remoteDataSource;

  FoundationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> forgotPassword(String email) async =>
      remoteDataSource.forgotPassword(email);

  @override
  Stream<List<FoundationEntity>> getAllUsers(FoundationEntity user) =>
      remoteDataSource.getAllUsers(user);

  @override
  Future<void> getCreateCurrentUser(FoundationEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentId() async => remoteDataSource.getCurrentId();

  @override
  Stream<List<FoundationEntity>> getSingleUser(FoundationEntity user) =>
      remoteDataSource.getSingleUser(user);

  @override
  Future<void> getUpdateUser(FoundationEntity user) async =>
      remoteDataSource.getUpdateUser(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(FoundationEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(FoundationEntity user) async =>
      remoteDataSource.signUp(user);
}
