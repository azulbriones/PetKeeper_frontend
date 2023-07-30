import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Functions {
  static Future<void> updateAvailability() async {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final date_time_field = {
      'date_time': DateTime.now(),
    };

    try {
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(date_time_field);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getProfilePhoto() async {
    String photoUrl;
    final firestore = FirebaseFirestore.instance;
    final idUser = FirebaseAuth.instance.currentUser?.uid;

    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(idUser).get();

    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data()!;
      // Accede al campo específico del documento y guárdalo en una variable
      photoUrl = data['profileUrl'];

      return photoUrl;
    } else {
      // Manejo de caso en el que el documento no existe
      print('El documento no existe.');
      return '';
    }
  }
}
