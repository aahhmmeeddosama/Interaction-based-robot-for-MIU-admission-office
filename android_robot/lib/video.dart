import 'dart:io';
import 'package:android_robot/apif.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'constants/app_color.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? selectVideo;
  String? recoResponse = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  XFile? videoFile;

  final ImagePicker _picker = ImagePicker();
  _camera() async {
    XFile? thevideo = await _picker.pickVideo(source: ImageSource.camera);
    selectVideo = File(thevideo!.path);

    if (thevideo != null) {
      setState(() {
        videoFile = thevideo;
      });
    }
    apif("http://192.168.0.1310:8003/Video_Split", selectVideo);
  }

  Widget videoPreview() {
    return Container(
        color: MyColors.myGrey,
        height: MediaQuery.of(context).size.height * (30 / 100),
        width: MediaQuery.of(context).size.width * (100 / 100),
        child: videoFile == null
            ? const Center(
                child:
                    Icon(Icons.videocam, color: MyColors.myWhite, size: 50.0),
              )
            : FittedBox(
                child: mounted
                    ? Chewie(
                        controller: ChewieController(
                            videoPlayerController: VideoPlayerController.file(
                                File(videoFile!.path)),
                            aspectRatio: 3 / 2,
                            autoPlay: true,
                            looping: false),
                      )
                    : Container()));
  }

  Widget cameraButton() {
    return RaisedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Camera'),
            Icon(Icons.video_call, color: MyColors.myRed)
          ],
        ),
        onPressed: () {
          _camera();
        });
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyColors.myRed, // background
          onPrimary: MyColors.myWhite, // foreground
          shape: StadiumBorder(),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
        child: const Text('Submit'),
      ),
    );
  }

  Widget formName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          cursorColor: MyColors.myBlack,
          style: TextStyle(),
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: MyColors.myBlack),
            focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: MyColors.myBlack),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Admin', style: TextStyle(fontSize: 30)),
          backgroundColor: MyColors.myRed,
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  formName(),
                  const SizedBox(
                    height: 50.0,
                  ),
                  videoPreview(),
                  cameraButton(),
                ],
              ),
              submitButton(),
            ],
          ),
        ));
  }
}

// void main() {
//   runApp(MaterialApp(home: VideoScreen()));
// }
