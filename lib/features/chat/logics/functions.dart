import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Functions {
  static Future<void> updateAvailability() async {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final dateTimeField = {
      'date_time': DateTime.now(),
    };

    try {
      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(dateTimeField);
    } catch (e) {
      print(e);
    }
  }
}
