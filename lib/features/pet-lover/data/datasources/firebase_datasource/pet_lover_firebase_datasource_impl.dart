import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/data/models/pet_lover_model.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/global/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

String apiURL = serverURL;

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
  Stream<List<PetLoverEntity>> getAllFoundations(PetLoverEntity foundation) {
    final userCollection = firestore.collection("users");

    return userCollection
        .where("id", isNotEqualTo: foundation.id)
        .where("type", isEqualTo: "foundation")
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

    if (user.info != null && user.info != "") {
      userInformation['info'] = user.info;
    }

    if (user.payInfo != null && user.payInfo != "") {
      userInformation['payInfo'] = user.payInfo;
    }

    if (user.address != null && user.address != "") {
      userInformation['address'] = user.address;
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
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      // Subir el archivo a Firebase Storage
      String filePath = 'certificates/${userCredential.user!.uid}/certFile.pdf';
      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(filePath);

      // Sube el archivo PDF al bucket de Firebase Storage y escucha el estado de la tarea
      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(user.certFile);
      await uploadTask.whenComplete(() {});

      // Obtiene el enlace (URL) del archivo PDF subido
      String downloadURL = await storageReference.getDownloadURL();

      // Obtener la referencia a la colección "users"
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Crear un nuevo documento con el ID del usuario recién creado
      await usersCollection.doc(userCredential.user!.uid).set({
        'name': user.name,
        'email': user.email,
        'profileUrl': '',
        'id': userCredential.user!.uid,
        'type': user.type,
        'certFile': downloadURL,
        'info': user.info,
        'payInfo': user.payInfo,
        'address': user.address,
        'location': user.location,
      });

      // El documento se creó correctamente
      print('Usuario creado exitosamente');
    } catch (e) {
      // Hubo un error al crear el usuario o el documento
      print('Error: $e');
    }
  }

  @override
  Future<PetLoverEntity> getSingleFoundation(String foundationId) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection(
            'users') // Cambia 'users' por el nombre de tu colección de usuarios en Firestore
        .doc(
            foundationId) // Utiliza el UID del usuario como el ID del documento
        .get();

    PetLoverModel strayPet = PetLoverModel.fromSnapshot(userSnapshot);

    return strayPet;
  }
}
