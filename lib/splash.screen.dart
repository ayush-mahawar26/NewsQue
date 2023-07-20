import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/constant/firebase.const.dart';
import 'package:news_app/views/home.dart';
import 'package:news_app/services/api.service.dart';
import 'package:news_app/views/auth_views/login.auth.view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ApiService().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        animationDuration: const Duration(seconds: 1),
        splash: "assets/icons/newsicon.png",
        nextScreen: StreamBuilder(
          stream: FirebaseInstance.authInstance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScr();
            }

            return LoginAuthView();
          },
        ));
  }
}
