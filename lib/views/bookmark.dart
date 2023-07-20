import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/constant/firebase.const.dart';
import 'package:news_app/models/bookmark.model.dart';
import 'package:news_app/widgets/news.tile.dart';

class BookmarkView extends StatelessWidget {
  BookmarkView({super.key});

  List bookmarkList = [];
  final FirebaseAuth _auth = FirebaseInstance.authInstance;
  final FirebaseFirestore store = FirebaseInstance.firebaseStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Bookmark News"),
      ),
      body: FutureBuilder(
        future: store
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("news")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.docs.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                        children: [Icon(Icons.error), Text("No Bookmarks")]),
                  ),
                ],
              );
            }
            bookmarkList = snapshot.data!.docs;
            print(bookmarkList.length);
            print(bookmarkList);
            return ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                BookmarkModel model = BookmarkModel(
                    author: bookmarkList[index]["author"],
                    title: bookmarkList[index]["title"],
                    publishTime: bookmarkList[index]["publishOn"],
                    imgUrl: bookmarkList[index]["imgurl"]);
                return NewsTileModel().bookmark(model.author, model.title,
                    model.imgUrl, model.publishTime, context);
              },
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
