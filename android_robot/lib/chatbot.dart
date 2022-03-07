import 'dart:convert' show jsonDecode;
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  final List<String> _data = [];
  static const String BOT_URL =
      "https://flutter-chatbotapp54654.herokuapp.com/bot";
  Uri myURI = Uri.parse(BOT_URL);
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("ChatBot"),
      ),
      body: Stack(
        children: <Widget>[
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
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.message,
                        color: Colors.blue,
                      ),
                      hintText: "Text Here",
                      fillColor: Colors.white12,
                    ),
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (msg) {
                      getResponse();
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

  void getResponse() {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text);
      var client = getClient();
      try {
        client.post(
          myURI,
          body: {"query": queryController.text},
        ).then((response) {
          print(response.body);
          Map<String, dynamic> data = jsonDecode(response.body.toString());
          data.toString();
          insertSingleItem(data['response'] + "<bot>");
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
          color: mine ? Colors.blue : Colors.grey[200],
          padding: const BubbleEdges.all(10),
        ),
      ),
    ),
  );
}
