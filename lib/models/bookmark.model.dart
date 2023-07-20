import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkModel {
  String author;
  String title;
  Timestamp publishTime;
  String imgUrl;

  BookmarkModel(
      {required this.author,
      required this.title,
      required this.publishTime,
      required this.imgUrl});
}
