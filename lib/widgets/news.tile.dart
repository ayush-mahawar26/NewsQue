import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constant/size.config.dart';
import 'package:news_app/models/news.model.dart';
import 'package:news_app/services/firestore.service.dart';

class NewsTileModel {
  Widget bookmark(String author, String title, String imgurl,
      Timestamp publishTime, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConfig.width,
                  height: SizeConfig.height / 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (imgurl == "null")
                          ? Container(
                              color: Colors.grey[200],
                              height: SizeConfig.height,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline_outlined,
                                      size: 30,
                                    ),
                                    Text(
                                      "Sorry for unavailablity of Picture",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Image.network(
                              imgurl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: SizeConfig.width,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: SizeConfig.width / 2,
                            child: Text(
                              (author == "null")
                                  ? "Article by : Unknown"
                                  : "Article by : ${author}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: SizeConfig.width / 2,
                            child: Text(
                              (publishTime == "null")
                                  ? "Published on : Unknown"
                                  : "Published on : ${publishTime.toDate()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }

  Widget newTile(NewsModel news, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConfig.width,
                  height: SizeConfig.height / 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (news.urlToImage == null)
                          ? Container(
                              color: Colors.grey[200],
                              height: SizeConfig.height,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline_outlined,
                                      size: 30,
                                    ),
                                    Text(
                                      "Sorry for unavailablity of Picture",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Image.network(
                              news.urlToImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: SizeConfig.width,
                    child: Text(
                      news.title!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: SizeConfig.width / 2,
                            child: Text(
                              (news.author == null)
                                  ? "Article by : Unknown"
                                  : "Article by : ${news.author!}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: SizeConfig.width / 2,
                            child: Text(
                              (news.publishedAt == null)
                                  ? "Published on : Unknown"
                                  : "Published on : ${news.publishedAt!.day}-${news.publishedAt!.month}-${news.publishedAt!.year}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          String img = (news.urlToImage == null)
                              ? "null"
                              : news.urlToImage!;
                          String author =
                              (news.author == null) ? "null" : news.author!;

                          await FirestoreServices().addNewsToFirebase(img,
                              news.title!, author, news.publishedAt!, context);
                        },
                        child: const CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.bookmark_add)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
