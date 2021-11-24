import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:news_app/Provider/api_key.dart';
import 'package:news_app/model/news_model.dart';

class NewsProvider with ChangeNotifier {
  String categoryLabel = "Business";
  String newsType = "business";
  List<NewsModel> lstNews = [];

  updateWholeNews(String type, String label) {
    newsType = type;
    categoryLabel = label;
    notifyListeners();
  }

  getmyNews(String category) async {
    String key = apiKey;
    lstNews.clear();
    Response res = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$key'));

    var decodedNewsData = jsonDecode(res.body);
    List newsList = decodedNewsData['articles'];

    for (int news = 0; news < newsList.length; news++) {
      Map currentNews = newsList[news];
      NewsModel newsModel = NewsModel(
          headline: currentNews["title"].toString(),
          authorName: currentNews["author"].toString(),
          newsUrl: currentNews["url"].toString(),
          imgUrl: currentNews["urlToImage"].toString());

      lstNews.add(newsModel);
    }
    return 1;
  }
}
