import 'package:android_robot/video.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: VideoScreen(),

    );
  }
}
