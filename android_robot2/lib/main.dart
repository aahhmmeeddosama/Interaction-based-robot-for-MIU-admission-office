import 'package:android_robot/admission_screen.dart';
import 'package:android_robot/chatbot.dart';
import 'package:flutter/material.dart';
import 'add_q_a.dart';
import 'identify_user.dart';
import 'welcome_screen.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: TTS(),
      //home: SpeechScreen(),
      //home: Admission(),
      home: Welcome_screen(),
      //home:IdentifyUser()
      //home: Staff(),
      //home: Add_Q_A(),
      //home: Delete(),
      //home: Edit(),
    );
  }
}
