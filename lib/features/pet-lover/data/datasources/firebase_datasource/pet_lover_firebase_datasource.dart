import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

abstract class PetLoverFirebaseDataSource {
  Future<void> getCreateCurrentUser(PetLoverEntity user);
  Future<void> forgotPassword(String email);
  Future<bool> isSignIn();
  Future<void> signIn(PetLoverEntity user);
  Future<void> signUp(PetLoverEntity user);
  Future<void> signOut();
  Future<void> getUpdateUser(PetLoverEntity user);
  Future<String> getCurrentId();
  Stream<List<PetLoverEntity>> getAllUsers(PetLoverEntity user);
  Stream<List<PetLoverEntity>> getAllFoundations(PetLoverEntity foundation);
  Future<PetLoverEntity> getSingleFoundation(String foundationId);
  Stream<List<PetLoverEntity>> getSingleUser(PetLoverEntity user);
}
