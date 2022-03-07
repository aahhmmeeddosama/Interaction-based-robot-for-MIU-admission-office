import 'package:android_robot/admission_screen.dart';
import 'package:android_robot/chatbot.dart';
import 'package:flutter/material.dart';

import 'ddddd.dart';
import 'identify_user.dart';
import 'welcome_screen.dart';
import 'zzzzzzzzz.dart';


Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'MIU ADMISSION',
      //home: TTS(),
      //home: SpeechScreen(),
      //home: Admission(),
      //home: ChatBot(),
      home: Welcome_screen(),
      //home:IdentifyUser()
      //home: Staff(),
      // home: Add(),
      //home: Delete(),
      //home: Edit(),

    );
  }
}
