import 'dart:io';
import 'package:android_robot/admission_side.dart';
import 'package:android_robot/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'apif.dart';
import 'chatbot.dart';
import 'constants/app_color.dart';
import 'package:page_transition/page_transition.dart';

import 'constants/ip.dart';

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
  bool detect = true;
  String message = "Please take a picture to continue";

  getImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 246, maxWidth: 246);
    selectImage = File(pickedImage!.path);

    recoResponse = await apif(ip+"8003/reco", selectImage);
    emoResponse = await apif(ip+"8003/emotion", selectImage);
    ageResponse = await apif(ip+"8000/age", selectImage);
    genResponse = await apif(ip+"8000/gender", selectImage);
    print(recoResponse);
    print(emoResponse);
    print(ageResponse);
    print(genResponse);


    setState(() {});
    if (recoResponse == 'Ahmed') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdmissionSide()));
    } else if (recoResponse == 'unknown') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatBot(
                  recoResponse!, emoResponse!, ageResponse!, genResponse!)));
    } else if (recoResponse == 'No face Detected' ||
        emoResponse == 'No face Detected' ||
        ageResponse == 'No face Detected' ||
        genResponse == 'No face Detected') {
      detect = false;
      setState(() {
        detect == false
            ? message =
                "Please stand upright and try to take another picture to continue"
            : selectImage = null;
      });
    }
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
        centerTitle: true,
        title: Text('Identify User', style: TextStyle(fontSize: 30)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            PageTransition(
              curve: Curves.linear,
              type: PageTransitionType.scale,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: Welcome_screen(),
            ),
          ),
        ),
        backgroundColor: MyColors.myRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectImage == null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: MyColors.myRed,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25, /////
                        color: MyColors.myRed,

                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //   onPressed: getImage,
      //   child: Icon(Icons.add_a_photo, color: Colors.white,
      //     size: 50.0),
      //   backgroundColor: Colors.red,
      // ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: getImage,
            child: Icon(Icons.add_a_photo, color: MyColors.myWhite, size: 30.0),
            backgroundColor: MyColors.myRed,
          ),
        ),
      ),
    );
  }
}
