import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/data/models/pet_lover_model.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

class PetLoverFirebaseDataSourceImpl implements PetLoverFirebaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  PetLoverFirebaseDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Stream<List<PetLoverEntity>> getAllUsers(PetLoverEntity user) {
    final userCollection = firestore.collection("users");

    return userCollection
        .where("id", isNotEqualTo: user.id)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((e) => PetLoverModel.fromSnapshot(e))
          .toList();
    });
  }

  @override
  Future<void> getCreateCurrentUser(PetLoverEntity user) async {
    final userCollection = firestore.collection("users");

    final id = await getCurrentId();

    userCollection.doc(id).get().then((userDoc) {
      if (!userDoc.exists) {
        final newUser = PetLoverModel(
          email: user.email,
          id: id,
          profileUrl: user.profileUrl,
          name: user.name,
        ).toDocument();

        userCollection.doc(id).set(newUser);
      } else {
        print("User already exists");
        return;
      }
    });
  }

  @override
  Future<String> getCurrentId() async => auth.currentUser!.uid;

  @override
  Stream<List<PetLoverEntity>> getSingleUser(PetLoverEntity user) {
    final userCollection = firestore.collection("users");

    return userCollection
        .limit(1)
        .where("id", isEqualTo: user.id)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((e) => PetLoverModel.fromSnapshot(e))
          .toList();
    });
  }

  @override
  Future<void> getUpdateUser(PetLoverEntity user) async {
    final userCollection = firestore.collection("users");

    Map<String, dynamic> userInformation = Map();

    if (user.profileUrl != null && user.profileUrl != "") {
      userInformation['profileUrl'] = user.profileUrl;
    }
    if (user.name != null && user.name != "") {
      userInformation['name'] = user.name;
    }

    await userCollection.doc(user.id).update(userInformation);
  }

  @override
  Future<bool> isSignIn() async {
    return auth.currentUser?.uid != null;
  }

  @override
  Future<void> signIn(PetLoverEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUp(PetLoverEntity user) async {
    await auth
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) {
      getCreateCurrentUser(user);
    });
  }
}
