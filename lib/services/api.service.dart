import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news.model.dart';

class ApiService {
  String apiUrl =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=500a796e0a8c4635828e9eb76f74d238";

  static List<NewsModel> allNews = [];

  Future<List> getNews() async {
    Uri news_uri = Uri.parse(apiUrl);

    http.Response res = await http.get(news_uri);

    Map toJson = await jsonDecode(res.body);

    allNews.clear();

    for (Map<String, dynamic> i in toJson["articles"]) {
      NewsModel news = NewsModel.fromJson(i);
      allNews.add(news);
    }

    return allNews;
  }
}
