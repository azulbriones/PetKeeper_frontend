import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_keeper_front/features/foundation/data/datasources/firebase_datasource/foundation_firebase_datasource.dart';
import 'package:pet_keeper_front/features/foundation/data/models/foundation_model.dart';
import 'package:pet_keeper_front/features/foundation/domain/entities/foundation_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/data/models/pet_lover_model.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

class FoundationFirebaseDataSourceImpl implements FoundationFirebaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  FoundationFirebaseDataSourceImpl(
      {required this.firestore, required this.auth});

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Stream<List<FoundationEntity>> getAllUsers(FoundationEntity user) {
    final userCollection = firestore.collection("users");

    return userCollection
        .where("id", isNotEqualTo: user.id)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((e) => FoundationModel.fromSnapshot(e))
          .toList();
    });
  }

  @override
  Future<void> getCreateCurrentUser(FoundationEntity user) async {
    final userCollection = firestore.collection("users");

    final id = await getCurrentId();

    userCollection.doc(id).get().then((userDoc) {
      if (!userDoc.exists) {
        final newUser = FoundationModel(
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
  Stream<List<FoundationEntity>> getSingleUser(FoundationEntity user) {
    final userCollection = firestore.collection("users");
    print('CURRENT ID: ${user.id}');

    return userCollection
        .limit(1)
        .where("id", isEqualTo: user.id)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((e) => FoundationModel.fromSnapshot(e))
          .toList();
    });
  }

  @override
  Future<void> getUpdateUser(FoundationEntity user) async {
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
  Future<void> signIn(FoundationEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUp(FoundationEntity user) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      // Obtener la referencia a la colección "users"
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Crear un nuevo documento con el ID del usuario recién creado
      await usersCollection.doc(userCredential.user!.uid).set({
        'name': user.name,
        'email': user.email,
        'profileUrl': '',
        'id': userCredential.user!.uid,
        'type': 'foundation',
      });

      // El documento se creó correctamente
      print('Usuario creado en Firestore');
    } catch (e) {
      // Hubo un error al crear el usuario o el documento
      print('Error: $e');
    }
  }
}
