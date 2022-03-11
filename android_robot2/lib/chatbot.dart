import 'dart:convert' show jsonDecode;
import 'package:bubble/bubble.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:http/http.dart' as http;


import 'camerax.dart';

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

  late SpeechRecognition _speech;

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;







  ///////////////////////////////////////////////////////////////
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  final List<String> _data = [];
  String? nurl;
  static const String BOT_URL =
      "http://192.168.1.10:5000/bot?message=";
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
                        icon: Icon(Icons.mic, color:Color.fromARGB(255, 214, 22, 8)),
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



  @override
  initState() {

    super.initState();

    _speech = SpeechRecognition();
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

    if(ageResponse=='(25-32)')
      setState(() {
        rate=0.5;
        pitch=1.0;
        volume=1.0;
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
            color: mine ? Color.fromARGB(255, 214, 22, 8) : Colors.grey[200],
            padding: const BubbleEdges.all(10),
          ),
        ),
      ),
    );
  }


}
