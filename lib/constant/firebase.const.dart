import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInstance {
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
}
