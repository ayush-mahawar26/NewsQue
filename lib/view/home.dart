// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Service/news_api_data.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view%20model/news_view_model.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsHomeScreen();
  }
}

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  String categoryOfNews = "Business Category";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NewsQue",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 40),
              ),
              Text(
                categoryOfNews,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Center(
                  child: FutureBuilder(
                    future: GettingNewsFromApi().getmyNews(categoryOfNews),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print("Data is Available");
                        List<NewsModel> lst = GettingNewsFromApi.lstOfNews;
                        return Center(
                            child: ListView.builder(
                          itemCount: lst.length,
                          itemBuilder: (context, index) {
                            return NewsViewModel().newsViewModel(
                                lst[index].headline,
                                lst[index].authorName,
                                lst[index].imgUrl,
                                lst[index].newsUrl,
                                context);
                          },
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
