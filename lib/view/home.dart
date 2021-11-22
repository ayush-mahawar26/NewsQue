// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view%20model/dailog_model.dart';
import 'package:news_app/view%20model/news_view_model.dart';
import 'package:provider/provider.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                      Consumer<NewsProvider>(
                        builder: (context, newsProvider, _) => Text(
                          newsProvider.categoryLabel,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        // newsProvider.updateWholeNews();
                        // newsProvider.getmyNews(newsProvider.newsType);

                        showDialog(
                            context: context, builder: (_) => MyCustomDialog());
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[200]),
                          elevation: MaterialStateProperty.all(2),
                          // side: MaterialStateProperty.all(BorderSide(width: 2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      icon:
                          Icon(Icons.filter_list_outlined, color: Colors.black),
                      label: Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Center(
                  child: Consumer<NewsProvider>(
                    builder: (context, newsProvider, _) => FutureBuilder(
                      future: newsProvider.getmyNews(newsProvider.newsType),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print("Data is Available");
                          List<NewsModel> lst = newsProvider.lstNews;
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
