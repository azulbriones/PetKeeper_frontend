import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_keeper_front/features/pet-lover/data/datasources/firebase_datasource/pet_lover_firebase_datasource.dart';
import 'package:pet_keeper_front/features/pet-lover/data/models/pet_lover_model.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

String apiURL = serverURL;

class PetLoverFirebaseDataSourceImpl implements PetLoverFirebaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  final StreamController<List<PetLoverEntity>> _userStreamController =
      StreamController<List<PetLoverEntity>>();
  Stream<List<PetLoverEntity>>? _userStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _streamSubscription;

  PetLoverFirebaseDataSourceImpl({required this.firestore, required this.auth});

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
    // Verificar si ya hay una suscripción activa y cancelarla antes de crear una nueva
    _streamSubscription?.cancel();

    _streamSubscription = userCollection
        .limit(1)
        .where("id", isEqualTo: user.id)
        .snapshots()
        .listen((querySnapshot) {
      List<PetLoverEntity> users =
          querySnapshot.docs.map((e) => PetLoverModel.fromSnapshot(e)).toList();

      _userStreamController.add(users);
    });

    _userStream = _userStreamController.stream;
    print('USER STREAM $_userStream');
    return _userStream!;
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
  Future<bool> isVerified() async {
    return auth.currentUser?.emailVerified != false;
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
  Future<void> sendVerificationEmail(email) async {
    try {
      await auth.currentUser!.sendEmailVerification();
      toastOk('Hemos enviado el correo de confirmación');
    } catch (e) {
      toast('Ha ocurrido un error al procesar su solicitud: $e');
    }
  }

  @override
  Future<void> signUp(PetLoverEntity user) async {
    String downloadURL = '';
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      User? userV = FirebaseAuth.instance.currentUser;
      userV!.sendEmailVerification();

      if (user.certFile != null) {
        // Subir el archivo a Firebase Storage
        String filePath =
            'certificates/${userCredential.user!.uid}/certFile.pdf';
        firebase_storage.Reference storageReference =
            firebase_storage.FirebaseStorage.instance.ref().child(filePath);

        // Sube el archivo PDF al bucket de Firebase Storage y escucha el estado de la tarea
        firebase_storage.UploadTask uploadTask =
            storageReference.putFile(user.certFile);
        await uploadTask.whenComplete(() {});

        // Obtiene el enlace (URL) del archivo PDF subido
        downloadURL = await storageReference.getDownloadURL();
      }

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
  Future<void> forgotPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      toastOk('Hemos enviado el correo de restablecimiento a su correo');
    } on FirebaseAuthException catch (e) {
      toast('Error al intentar procesar su solicitud: $e');
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

  @override
  Future<void> deleteAccount() async {
    String uid = auth.currentUser!.uid;

    _streamSubscription?.cancel();
    _userStreamController.close();
    // Eliminar la cuenta de Firebase Auth
    await deleteUser();

    // Eliminar documentos de las colecciones que contienen el UID del usuario
    await deleteDocuments(uid);
  }

  Future<void> deleteUser() async {
    try {
      // Obtener el usuario actualmente autenticado
      User? user = auth.currentUser;

      // Verificar si el usuario está autenticado
      if (user != null) {
        // Eliminar la cuenta del usuario
        await user.delete();
      }
    } catch (e) {
      print("Error al eliminar la cuenta: $e");
    }
  }

  // Método para eliminar documentos de diferentes colecciones
  Future<void> deleteDocuments(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // Crear una transacción en lote (batch)
      WriteBatch batch = firestore.batch();

      // Obtener las referencias a los documentos que deben ser eliminados
      CollectionReference collection1Ref = firestore.collection('users');
      // CollectionReference collection2Ref = firestore.collection('adopts_pets');
      // CollectionReference collection3Ref = firestore.collection('stray_pets');

      QuerySnapshot querySnapshot1 =
          await collection1Ref.where('id', isEqualTo: uid).get();
      // QuerySnapshot querySnapshot2 =
      //     await collection2Ref.where('uid', isEqualTo: uid).get();
      // QuerySnapshot querySnapshot3 =
      //     await collection3Ref.where('uid', isEqualTo: uid).get();

      // Agregar las operaciones de eliminación al lote (batch)
      for (var doc in querySnapshot1.docs) {
        batch.delete(doc.reference);
      }

      // for (var doc in querySnapshot2.docs) {
      //   batch.delete(doc.reference);
      // }

      // for (var doc in querySnapshot3.docs) {
      //   batch.delete(doc.reference);
      // }

      // Ejecutar el lote (batch) para eliminar los documentos
      await batch.commit();
      toastOk('Su cuenta ha sido eliminada');
    } catch (e) {
      toast("Error al eliminar su cuenta: $e");
    }
  }
}
