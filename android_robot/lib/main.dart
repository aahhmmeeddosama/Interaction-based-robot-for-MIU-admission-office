import 'package:android_robot/admission_side.dart';
import 'package:android_robot/video.dart';
//import 'package:android_robot/chatbot.dart';
import 'package:flutter/material.dart';
import 'add_to_dataset.dart';
import 'chatbot.dart';
import 'delete_from_dataset.dart';
import 'edit_from_dataset.dart';
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
      // home: SpeechScreen(),
      //home: AdmissionSide(),
      // home: ChatBot(),
      // home: SpeechSampleApp(),
      // home: Welcome_screen(),
      // home: VideoScreen(),
      home: IdentifyUser(),
      // home: VideoScreen(),
      // home: Staff(),
      //home: AddToDataset("aaa"),
      // home: DeleteFromDataset("aaa"),
      // home: EditFromDataset("aa"),
    );
  }
}
