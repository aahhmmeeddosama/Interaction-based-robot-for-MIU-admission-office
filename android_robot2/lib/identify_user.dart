import 'dart:convert';
import 'dart:io';
import 'package:android_robot/admission_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'apif.dart';
import 'add_q_a.dart';
import 'chatbot.dart';

class IdentifyUser extends StatefulWidget {
  const IdentifyUser({Key? key}) : super(key: key);

  @override
  State<IdentifyUser> createState() => _IdentifyUserState();
}

class _IdentifyUserState extends State<IdentifyUser> {
  File? selectImage;
  String? recoResponse = "";
  String? emoResponse = "";
  String? ageResponse = "";
  String? genResponse = "";

  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    selectImage = File(pickedImage!.path);
    recoResponse = "";
    setState(() {});
    recoResponse = await apif("http://192.168.1.10:8003/reco", selectImage);
    emoResponse = await apif("http://192.168.1.10:8003/emotion", selectImage);
    ageResponse = await apif("http://192.168.1.10:8000/age", selectImage);
    genResponse = await apif("http://192.168.1.10:8000/gender", selectImage);

    Route _createRoute2() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChatBot(recoResponse!, emoResponse!, ageResponse!, genResponse!),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.5, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInCirc;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    setState(() {});
    if (recoResponse == 'Ahmed')
      Navigator.of(context).push(_createRoute());
    else
      Navigator.of(context).push(_createRoute2());
  }

  /*uploadImage() async {

    recoResponse = await apif("http://192.168.1.10:8003/reco",selectImage);
    emoResponse = await apif("http://192.168.1.10:8003/emotion",selectImage);
    ageResponse = await apif("http://192.168.1.10:8000/age",selectImage);
    genResponse = await apif("http://192.168.1.10:8000/gender",selectImage);


    setState(() {});
    if (recoResponse=='Ahmed')
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  Admission()));

    else
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatBot(recoResponse!,emoResponse!,ageResponse!,genResponse!)));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(recoResponse!),
            Text(emoResponse!),
            Text(ageResponse!),
            Text(genResponse!),
            selectImage == null
                ? Text("please pick image to continue")
                : Image.file(selectImage!),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo, color: Colors.white),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Admission(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.5, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
