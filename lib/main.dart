// ignore_for_file: prefer_const_constructors, unused_import

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/home.dart';

void main() {
  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   useInheritedMediaQuery: true,
    //   locale: DevicePreview.locale(context),
    //   home: HomeScr(),
    // );

    return MaterialApp(
      home: HomeScr(),
    );
  }
}
