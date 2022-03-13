import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'add_q_a.dart';
import 'camerax.dart';
import 'chatbot.dart';
import 'identify_user.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:page_transition/page_transition.dart';


const languages = const [
  const Language('Arabic', 'ar-EG'),
  const Language('English', 'en-US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class Welcome_screen extends StatefulWidget {

  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

class _Welcome_screenState extends State<Welcome_screen> {
  late SpeechRecognition _speech;
  bool _speechRecognitionAvailable = true;
  bool _isListening = true;
  String transcription = '';
  Language selectedLang = languages.last;

  @override
  initState() {
    activateSpeechRecognizer();
    start();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text(
              'Welcome to MIU!',
              style: TextStyle(
                fontSize: 45.0,
                fontFamily: "arial",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Image.asset('assets/images/logo_miu.png'),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text(
              ' Please say hey Robot ',
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: "arial",
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.fromLTRB(20, 150, 20, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[700], // background
                  onPrimary: Colors.white, // foreground
                  minimumSize: Size(200,50),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  dispose();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.linear,
                      type: PageTransitionType.scale,
                      duration: Duration(milliseconds: 500),
                      reverseDuration: Duration(milliseconds: 300),
                      alignment: Alignment.topCenter,
                      child: const IdentifyUser(),
                    ),
                  );
                },
                child: Text('start'),
              )),
        ]),
      ),
    );
  }

  void start() => _speech.activate(selectedLang.code).then((_) {
    return _speech.listen().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) {
    setState(() => _isListening = false);
  });

  void onSpeechAvailability(bool result) {
    setState(() => _speechRecognitionAvailable = result);
    if( transcription=="hey robot") {
      dispose();
      Navigator.push(
        context,
        PageTransition(
          curve: Curves.linear,
          type: PageTransitionType.scale,
          duration: Duration(milliseconds: 500),
          reverseDuration: Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: const IdentifyUser(),
        ),
      );
    }

    else
      start();

  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate(selectedLang.toString()).then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  void dispose() {
    cancel();
    stop();
    super.dispose();
  }


  Future<void> camx() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    //camera = await availableCameras();
    final List<CameraDescription>? camera = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = camera![1];
    TakePictureScreen(
      // Pass the appropriate camera to the TakePictureScreen widget.
      camera: firstCamera,
    );
  }

}
