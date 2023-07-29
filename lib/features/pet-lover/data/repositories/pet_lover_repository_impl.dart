import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/repositories/pet_lover_repository.dart';

class PetLoverRepositoryImpl implements PetLoverRepository {
  final PetLoverFirebaseDataSource remoteDataSource;

  PetLoverRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> forgotPassword(String email) async =>
      remoteDataSource.forgotPassword(email);

  @override
  Stream<List<PetLoverEntity>> getAllUsers(PetLoverEntity user) =>
      remoteDataSource.getAllUsers(user);

  @override
  Future<void> getCreateCurrentUser(PetLoverEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentId() async => remoteDataSource.getCurrentId();

  @override
  Stream<List<PetLoverEntity>> getSingleUser(PetLoverEntity user) =>
      remoteDataSource.getSingleUser(user);

  @override
  Future<void> getUpdateUser(PetLoverEntity user) async =>
      remoteDataSource.getUpdateUser(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<bool> isVerified() async => remoteDataSource.isVerified();

  @override
  Future<void> signIn(PetLoverEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> deleteAccount() async => remoteDataSource.deleteAccount();

  @override
  Future<void> signUp(PetLoverEntity user) async =>
      remoteDataSource.signUp(user);

  @override
  Future<void> sendVerificationEmail(String email) async =>
      remoteDataSource.sendVerificationEmail(email);

  @override
  Stream<List<PetLoverEntity>> getAllFoundations(PetLoverEntity foundation) =>
      remoteDataSource.getAllFoundations(foundation);

  @override
  Future<PetLoverEntity> getSingleFoundation(String foundationId) =>
      remoteDataSource.getSingleFoundation(foundationId);
}
