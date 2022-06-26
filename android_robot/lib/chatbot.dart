import 'dart:math';
import 'package:android_robot/api.dart';
import 'package:android_robot/constants/app_color.dart';
import 'package:android_robot/welcome_screen.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'constants/ip.dart';
import 'sendd.dart';
import 'dart:async';

class ChatBot extends StatefulWidget {
  final String recoResponse; final String emoResponse; final String ageResponse; final String genResponse;

  const ChatBot(
      this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse,
      {Key? key})
      : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState(
      this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse);
}

enum TtsState { playing }

class _ChatBotState extends State<ChatBot> {
  final String recoResponse; final String emoResponse; final String ageResponse; final String genResponse;
  _ChatBotState(
      this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse);

  String mesageSend = '';
  late String a;
  Timer? searchOnStoppedTyping;

  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  final List<String> _data = [];
  String? newURL;
  static const String botUrl = ip+"5000/bot?message=";
  static const String reviewUrl = ip+"8001/applicant_comment?name="; //ahmed&comment=no
  TextEditingController queryController = TextEditingController();
  TextEditingController queryControllerReview = TextEditingController();
  TextEditingController queryControllerReview1 = TextEditingController();

  late FlutterTts flutterTts;
  String? language;
  String? engine;
  String? ttsVoiceNmae;

  //String? ttsVoiceLocale;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  //String? _newVoiceText = "hello how can i help you";

  TtsState ttsState = TtsState.playing;

  get isPlaying => ttsState == TtsState.playing;

  void startListening() {
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    getQuestionResponse(lastWords);
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    //print(selectedVal);
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  // void _logEvent(String eventDescription) {
  //   if (_logEvents) {
  //     var eventTime = DateTime.now().toIso8601String();
  //     print('$eventTime $eventDescription');
  //   }
  // }

  void sendReview(String name , String reviwe) {
    newURL = reviewUrl + name + "&comment=" + reviwe;
    Uri myURL = Uri.parse(newURL!);
    send.sendReview(myURL);
  }

  void getQuestionResponse(String text) {
    if (text.isNotEmpty) {
      insertSingleItem(text);
      newURL = botUrl + text;
      Uri myURL = Uri.parse(newURL!);
      var client = getClient();
      try {
        client.post(
          myURL,
          body: {"message": queryController.text},
        ).then((response) {
          var data = response;
          String res = data.body.toString();
          setState(() {
            language = res.substring(res.length - 5);
            if (language == "en-AU") {
              ttsVoiceNmae = "Karen";
            } else {
              ttsVoiceNmae = "Maged";
            }
          });
          insertSingleItem(res.substring(0, res.length - 6) + "<bot>");
          txtToSpeech(res.substring(0, res.length - 6));
        });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listkey.currentState!.insertItem(_data.length - 1);
  }

  http.Client getClient() {
    return http.Client();
  }

  _onChangeHandler() {
    const duration = Duration(
        milliseconds:
            60000); // set the duration that you want call pop() after that. 1sec =1000mill

    setState(() {
      searchOnStoppedTyping?.cancel(); // clear timer
      searchOnStoppedTyping = Timer(duration, () => navigateHome());
    });
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
      debugLogging: true,
    );
    if (hasSpeech) {
      // Get the list of languages installed on the supporting platform so they
      // can be displayed in the UI for selection by the user.
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }
  }

  Future txtToSpeech(String message) async {
    if(ageResponse=='(48-53)'||ageResponse=='(38-43)'||ageResponse=='(25-32)')
      setState(() {
        rate=0.3;
        pitch=0.5;
        volume=1.5;
      });

    // if(emoResponse=='Happy')
    //   setState(() {
    //     message = "i am happy to see you." + message;
    //   });


    //await flutterTts.areLanguagesInstalled(["en-AU", "en-US", "ar-SA"]);
    await flutterTts.setLanguage(language.toString());
    await flutterTts.setVoice({
      "name": ttsVoiceNmae.toString(),
      "locale": language.toString()
    }); //Karen	en-AU
    await flutterTts.setQueueMode(1);

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (message.isNotEmpty) {

      await flutterTts.speak(message);
    }
  }

  @override
  initState() {
    initSpeechState();

    super.initState();
    _onChangeHandler();
    flutterTts = FlutterTts();
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  navigateHome() {
    dispose();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      PageTransition(
        curve: Curves.linear,
        type: PageTransitionType.scale,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 300),
        alignment: Alignment.topCenter,
        child: Welcome_screen(),
      ),
    );
  }

  Widget buildItem(String item, Animation animation, int index) {
    bool mine = item.endsWith("<bot>");
    dynamic ani = animation;
    return SizeTransition(
      sizeFactor: ani,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          alignment: mine ? Alignment.topLeft : Alignment.topRight,
          child: Bubble(
            child: Text(
              item.replaceAll("<bot>", ""),
              style: TextStyle(
                  color: mine ? MyColors.myWhite : MyColors.myBlack,
                  fontSize: 40),
            ),
            color: mine ? MyColors.myRed : MyColors.myGrey,
            padding: const BubbleEdges.all(10),
          ),
        ),
      ),
    );
  }

  submitReview(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "what is your opinion of our System",
        style: TextStyle(
          fontSize: 20,
          color: MyColors.myBlack,
          fontFamily: "Times New Roman",
        ),
      ),
      content: Form(
        child: SizedBox(
          height: 200,
          width: 300,
          child: Column(
            children: [

              TextField(
                style: const TextStyle(
                    color: MyColors.myBlack, fontSize: 30),
                decoration: InputDecoration(
                  hintText: "Your name",
                  fillColor: MyColors.myWhite,
                ),
                controller: queryControllerReview,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: TextField(
                  style: const TextStyle(
                      color: MyColors.myBlack, fontSize: 30),
                  decoration: InputDecoration(
                    hintText: "Your review",
                    fillColor: MyColors.myWhite,
                  ),
                  controller: queryControllerReview1,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Submit", style: TextStyle(color: MyColors.myRed ,fontSize: 20)),
          onPressed: () {
            print(queryControllerReview.text);
            print(queryControllerReview1.text);
            sendReview(queryControllerReview.text,queryControllerReview1.text);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Cancel", style: TextStyle(color: MyColors.myRed,fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget reviewButton() {
    return TextButton(
      onPressed: () {
        submitReview(context);

      },
      child: const Text('Submit Review',   style: TextStyle(
         fontSize: 25.0,
        // fontFamily: "arial",
        color: MyColors.myRed,

      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onChangeHandler,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.myRed,
            centerTitle: true,
            title: const Text("ChatBot", style: TextStyle(fontSize: 30)),
          ),
          body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AnimatedList(
                    key: _listkey,
                    initialItemCount: _data.length,
                    itemBuilder:
                        (BuildContext context, int index, Animation animation) {
                      return buildItem(_data[index], animation, index);
                    },
                  ),
                ),
                SessionOptionsWidget(_currentLocaleId, _switchLang, _localeNames,
                    _logEvents, _switchLogging),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.linearToSrgbGamma(),
                    child: Container(
                      color: MyColors.myWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child:
                            //reviewButton(),
                            TextField(
                              style: const TextStyle(
                                  color: MyColors.myBlack, fontSize: 30),
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.message,
                                  size: 30.0,
                                  color: MyColors.myRed,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    startListening();

                                    setState(() {
                                      mesageSend = queryController.text;
                                    });
                                    getQuestionResponse(mesageSend);
                                  },
                                  icon: const Icon(Icons.mic,
                                      color: Colors.red, size: 30.0),
                                ),
                                hintText: "Text Here",
                                fillColor: MyColors.myWhite,
                              ),
                              controller: queryController,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (msg) {
                                setState(() {
                                  mesageSend = queryController.text;
                                });
                                getQuestionResponse(mesageSend);
                              },
                            ),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(300,950,50,0),
                  child: reviewButton(),
                ),
              ],
            ),
          ),
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(this.currentLocaleId, this.switchLang,
      this.localeNames, this.logEvents, this.switchLogging,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final List<LocaleName> localeNames;
  final bool logEvents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              const Text('Language: ', style: TextStyle(fontSize: 30)),
              DropdownButton<String>(
                onChanged: (selectedVal) => switchLang(selectedVal),
                value: currentLocaleId,
                items: localeNames
                    .map(
                      (localeName) => DropdownMenuItem(
                        value: localeName.localeId,
                        child: Text(localeName.name),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Log events: '),
              Checkbox(
                value: logEvents,
                onChanged: switchLogging,
              ),
            ],
          )
        ],
      ),
    );
  }
}
