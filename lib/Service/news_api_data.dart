// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/api_key.dart';
import 'package:news_app/model/news_model.dart';

class GettingNewsFromApi {
  static List<NewsModel> lstOfNews = [];

  getmyNews(String catergory) async {
    String key = apiKey;

    Response res = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$key'));

    var decodedNewsData = jsonDecode(res.body);
    List newsList = decodedNewsData['articles'];

    for (int news = 0; news < newsList.length; news++) {
      Map currentNews = newsList[news];
      NewsModel newsModel = NewsModel(
          headline: currentNews["title"].toString(),
          authorName: currentNews["author"].toString(),
          newsUrl: currentNews["url"].toString(),
          imgUrl: currentNews["urlToImage"].toString());

      lstOfNews.add(newsModel);
    }

    return lstOfNews;
  }
}
