// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsViewModel {
  void _launchNewsUrl(String newsUrl, BuildContext context) async {
    if (await canLaunch(newsUrl)) {
      await launch(newsUrl);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(newsUrl)));
      print(newsUrl);
    }
  }

  Widget newsViewModel(String headline, String author, String imgUrl,
      String newsUrl, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width - 50,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              imageUrl: (imgUrl == "null")
                  ? '''https://images.unsplash.com/photo-1529173009247-f9876ff
                  9e4c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGV2ZW5
                  pbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'''
                  : imgUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            InkWell(
              onTap: () async {
                try {
                  await launch(newsUrl);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Can't Launch Url")));
                  print(e);
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  headline,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      (author == "null") ? "By - Unknown" : "By - $author",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
