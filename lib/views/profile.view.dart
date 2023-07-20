import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/constant/firebase.const.dart';
import 'package:news_app/constant/size.config.dart';
import 'package:news_app/views/auth_views/login.auth.view.dart';
import 'package:news_app/views/bookmark.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final FirebaseAuth _auth = FirebaseInstance.authInstance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.black,
                height: SizeConfig.height / 3,
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: SizeConfig.width / 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: SizeConfig.width / 10,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: SizeConfig.width / 10,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _auth.currentUser!.displayName.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                future: FirebaseInstance.firebaseStore
                                    .collection("users")
                                    .doc(_auth.currentUser!.uid)
                                    .collection("news")
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Row(
                                      children: [
                                        Text(
                                          "Total BookMarks : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                        Text(
                                          snapshot.data!.docs.length.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.white),
                                        )
                                      ],
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Row(
                                      children: [
                                        Text(
                                          "Total BookMarks : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      ],
                                    );
                                  }

                                  return Text(
                                    "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white),
                                  );
                                },
                              ),
                            ])
                      ],
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(
              width: SizeConfig.width,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.bookmark),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookmarkView()));
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("My Bookmarks"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(
              width: SizeConfig.width,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.exit_to_app),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginAuthView()),
                      (route) => false);
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Sign out"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
