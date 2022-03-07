import 'package:chatbot/test.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  //camera = await availableCameras();
  final List<CameraDescription>? camera = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = camera![1];

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: TakePictureScreen(
      // Pass the appropriate camera to the TakePictureScreen widget.
      camera: firstCamera,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //runApp(MyApp());
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chatbot",
    );
  }
}
