import 'dart:convert';
import 'dart:io';
import 'package:android_robot/admission_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'add_q_a.dart';
import 'chatbot.dart';


class IdentifyUser extends StatefulWidget {
  const IdentifyUser({Key? key}) : super(key: key);

  @override
  State<IdentifyUser> createState() => _IdentifyUserState();
}

class _IdentifyUserState extends State<IdentifyUser> {
  File? selectImage;
  String? message="";
  getImage() async {
    final pickedImage= await ImagePicker().getImage(source: ImageSource.camera);
    selectImage=File(pickedImage!.path);
    message="";
    setState(() {

    });
  }



  uploadImage() async {
    final request=http.MultipartRequest("POST", Uri.parse("http://192.168.1.11:8000/reco"));
    final headers={"content-type": "multipart/from-data"};
    request.files.add(
        http.MultipartFile('image', selectImage!.readAsBytes().asStream(),selectImage!.lengthSync(), filename: selectImage!.path.split("/").last)
    );
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resjson= res.body;
    message =resjson;
    setState(() {});
    if (message=="Ahmed")
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  Admission()));

    else
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChatBot()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(message!),
            selectImage==null? Text("please pick image to uploade"): Image.file(selectImage!),
            TextButton.icon(
                onPressed: uploadImage,
                icon: Icon(Icons.upload_file),
                label: Text("upload")
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: getImage,child: Icon(Icons.add_a_photo),),
    );

  }
}
