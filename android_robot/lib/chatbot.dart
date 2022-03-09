import 'dart:convert' show jsonDecode;
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}
enum TtsState { playing }

const languages = const [
  const Language('Arabic', 'ar-EG'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}


class _ChatBotState extends State<ChatBot> {

  String mesageSend = '';

  ////////////////////////////////////////////////////////////

  late SpeechRecognition _speech;

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  void activateSpeechRecognizer() {
    _speech = SpeechRecognition();
  }
  ///////////////////////////////////////////////////////////////
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  final List<String> _data = [];
  String? nurl;
  static const String BOT_URL =
      "http://192.168.1.11:5000/bot?message=";
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

  @override
  initState() {
    super.initState();
    initTts();
    activateSpeechRecognizer();
  }

  initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

  }

  Future _speak(String message) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (message != null) {
      if (message.isNotEmpty) {
        initTts();
        await flutterTts.speak(message);

      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Widget _btnSection() {

    return Container(
        padding: EdgeInsets.only(top: 50.0),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

        ]));
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

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
          AnimatedList(
            key: _listkey,
            initialItemCount: _data.length,
            itemBuilder:
                (BuildContext context, int index, Animation animation) {
              return buildItem(_data[index], animation, index);
            },
          ),
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
                          await _speech.listen();
                          _speech.setRecognitionResultHandler((String text){setState(() {  queryController.text=text;  });});
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
