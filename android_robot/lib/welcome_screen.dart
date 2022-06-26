import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'add_to_dataset.dart';
import 'chatbot.dart';
import 'constants/app_color.dart';
import 'constants/language.dart';
import 'identify_user.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:page_transition/page_transition.dart';

class Welcome_screen extends StatefulWidget {
  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

class _Welcome_screenState extends State<Welcome_screen> {
  late SpeechRecognition _speech;
  bool _speechRecognitionAvailable = true;
  bool _isListening = true;
  String transcription = '';
  Language selectedLang = Language.languages.last;

  void startSpeech() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancelSpeech() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stopSpeech() => _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool result) {
    setState(() => _speechRecognitionAvailable = result);
    if (transcription == "hey bot") {
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
    } else {
      startSpeech();
    }
  }

  void onSpeechRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onSpeechRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onSpeechRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void speechErrorHandler() => activateSpeechRecognizer();

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onSpeechRecognitionStarted);
    _speech.setRecognitionResultHandler(onSpeechRecognitionResult);
    _speech.setRecognitionCompleteHandler(onSpeechRecognitionComplete);
    _speech.setErrorHandler(speechErrorHandler);
    _speech.activate(selectedLang.toString()).then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  void dispose() {
    cancelSpeech();
    stopSpeech();
    super.dispose();
  }

  Widget StartButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(70, 150, 20, 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: MyColors.myRed, // background
            onPrimary: MyColors.myWhite, // foreground
            minimumSize: Size(200, 70),
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
          child: Text('start', style: TextStyle(fontSize: 40)),
        ));
  }

  @override
  initState() {
    activateSpeechRecognizer();
    startSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 100, 0, 0),
            child: Text(
              'Welcome to MIU!',
              style: TextStyle(
                fontSize: 80.0,
                fontFamily: "arial",
                color: MyColors.myBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Image.asset('assets/images/logo_miu.png'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 100, 0, 0),
            child: Text(
              ' Please say Hey Bot ',
              style: TextStyle(
                fontSize: 45.0,
                fontFamily: "arial",
                color: MyColors.myRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StartButton(),
        ]),
      ),
    );
  }
}
