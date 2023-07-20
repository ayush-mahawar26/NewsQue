import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constant/firebase.const.dart';
import 'package:news_app/views/home.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseInstance.authInstance;
  final FirebaseFirestore _store = FirebaseInstance.firebaseStore;

  _saveUser(String username, String email, String uid) async {
    await _store
        .collection("users")
        .doc(uid)
        .set({"email": email, "username": username});
  }

  void createAccount(
      String username, String email, String pass, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      await _auth.currentUser!.updateDisplayName(username);
      await _auth.currentUser!.updateEmail(email);
      await _saveUser(username, email, userCredential.user!.uid);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScr()), (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign Up Successfully !")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Weak Password"),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Already in use"),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void loginAccount(String email, String pass, BuildContext context) async {
    try {
      UserCredential cred = await FirebaseInstance.authInstance
          .signInWithEmailAndPassword(email: email, password: pass);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScr()), (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign In Successfully !")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Not Exist! Try Signing Up"),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Credentials"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
