import 'dart:convert' show jsonDecode;
import 'dart:math';
import 'package:bubble/bubble.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';



class ChatBot extends StatefulWidget {
  final String recoResponse; final String emoResponse; final String ageResponse; final String genResponse;

  const ChatBot(this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse,{Key? key}) : super(key: key);
  @override
  _ChatBotState createState() => _ChatBotState(this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse,);
}
enum TtsState { playing }

const languages = const [
  const Language('Arabic', 'ar-EG'),
  const Language('English', 'en-US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}


class _ChatBotState extends State<ChatBot> {
  final String recoResponse; final String emoResponse; final String ageResponse; final String genResponse;
  _ChatBotState(this.recoResponse,this.emoResponse,this.ageResponse,this.genResponse,);


  String mesageSend = '';
  late String a;

  ////////////////////////////////////////////////////////////

  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();


  Future<void> initSpeechState() async {
    _logEvent('Initialize');

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

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }








  ///////////////////////////////////////////////////////////////
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  final List<String> _data = [];
  String? nurl;
  static const String BOT_URL =
      "http://192.168.96.87:5000/bot?message=";
  TextEditingController queryController = TextEditingController();

  //////////////////////////////////////////
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText="hello how can i help you";

  TtsState ttsState = TtsState.playing;

  get isPlaying => ttsState == TtsState.playing;







  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text("ChatBot"),
      ),
      body: Stack(
        children: <Widget>[
          _btnSection(),
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
          SessionOptionsWidget(_currentLocaleId, _switchLang, _localeNames, _logEvents,_switchLogging),

          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.message,
                        color: Colors.red,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          startListening();

                          setState(() {
                            mesageSend=queryController.text;
                          });
                          getResponse(mesageSend);

                        },
                        icon: Icon(Icons.mic, color: Colors.red),
                      ),
                      hintText: "Text Here",
                      fillColor: Colors.white12,
                    ),
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted:(msg) {
                      setState(() {
                        mesageSend=queryController.text;
                      });
                      getResponse(mesageSend);
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  ////////////////////////////////////////////////////////////


  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });
    getResponse(lastWords);

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
    print(selectedVal);
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }



  ///////////////////////////////////////////////////////////

  void getResponse(String text) {
    if (text.length > 0) {
      this.insertSingleItem(text);
      nurl=BOT_URL+text;
      Uri myURI = Uri.parse(nurl!);

      var client = getClient();
      try {
        client.post(
          myURI,
          body: {"message": queryController.text},
        ).then((response) {
          print(response.body);
          var data = response;
          data.toString();

          insertSingleItem(data.body + "<bot>");
          _speak(data.body );

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



  @override
  initState() {
    initSpeechState();

    super.initState();

    flutterTts = FlutterTts();
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _speak(String message) async {

    if(ageResponse=='(48-53)'||ageResponse=='(38-43)')
      setState(() {
        rate=0.3;
        pitch=1.0;
        volume=1.5;
      });

    await flutterTts.areLanguagesInstalled(["en-AU", "en-US"]);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setQueueMode(1);

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    if (message != null) {
      if (message.isNotEmpty) {
        await flutterTts.speak(message);

      }
    }

  }

  Widget _btnSection() {

    return Container(
        padding: EdgeInsets.only(top: 50.0),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

        ]));
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
              style: TextStyle(color: mine ? Colors.white : Colors.black),
            ),
            color: mine ? Colors.red : Colors.grey[200],
            padding: const BubbleEdges.all(10),
          ),
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
              Text('Language: '),
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
              Text('Log events: '),
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