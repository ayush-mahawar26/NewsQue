import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/constant/firebase.const.dart';
import 'package:news_app/constant/size.config.dart';
import 'package:news_app/models/news.model.dart';
import 'package:news_app/services/api.service.dart';
import 'package:news_app/views/bookmark.dart';
import 'package:news_app/views/profile.view.dart';
import 'package:news_app/widgets/news.tile.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BookmarkView()));
        },
        backgroundColor: Colors.black,
        icon: const Icon(Icons.bookmark),
        label: const Text("My Bookmarks"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "NewsQue",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 50, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.chrome_reader_mode),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileView()));
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(CupertinoIcons.person),
                    ),
                  )
                ],
              ),
              Text(
                "Breaking News For You - ${FirebaseInstance.authInstance.currentUser!.displayName.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 2,
                width: SizeConfig.width - 10,
                color: Colors.grey[400],
              ),
              Expanded(
                  child: (ApiService().apiUrl.isNotEmpty)
                      ? ListView.builder(
                          itemCount: ApiService.allNews.length,
                          itemBuilder: (context, index) {
                            List<NewsModel> news = ApiService.allNews;
                            return NewsTileModel()
                                .newTile(news[index], context);
                          })
                      : FutureBuilder(
                          future: ApiService().getNews(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              ApiService.allNews.sort((a, b) {
                                return a.publishedAt!.compareTo(b.publishedAt!);
                              });
                              return ListView.builder(
                                  itemCount: ApiService.allNews.length,
                                  itemBuilder: (context, index) {
                                    List<NewsModel> news = ApiService.allNews;
                                    return NewsTileModel()
                                        .newTile(news[index], context);
                                  });
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Error Occured",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {}, child: Text("Retry"))
                                  ],
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }))
            ],
          ),
        ),
      ),
    );
  }
}
