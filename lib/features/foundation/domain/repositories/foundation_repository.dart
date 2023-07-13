import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

abstract class FoundationRepository {
  Future<void> getCreateCurrentUser(FoundationEntity user);
  Future<void> forgotPassword(String email);
  Future<bool> isSignIn();
  Future<void> signIn(FoundationEntity user);
  Future<void> signUp(FoundationEntity user);
  Future<void> signOut();
  Future<void> getUpdateUser(FoundationEntity user);
  Future<String> getCurrentId();
  Stream<List<FoundationEntity>> getAllUsers(FoundationEntity user);
  Stream<List<FoundationEntity>> getSingleUser(FoundationEntity user);
}
