import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constant/firebase.const.dart';

class FirestoreServices {
  final FirebaseAuth _auth = FirebaseInstance.authInstance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  addNewsToFirebase(String? imgurl, String title, String author,
      DateTime publishOn, BuildContext context) async {
    String useruid = _auth.currentUser!.uid;

    await _store.collection("users").doc(useruid).collection("news").doc().set({
      "title": title,
      "author": author,
      "publishOn": publishOn,
      "imgurl": imgurl
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Bookmarked your News")));
  }
}
