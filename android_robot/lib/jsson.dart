import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

Future<void> main() async {
  String url="http://127.0.0.1:5000/bot/view";
  final response=await http.get(Uri.parse(url));
  print(response.body);
}
class Intents {
  int? index;
  List<String>? pattern;
  List<String>? responses;
  String? tag;

  Intents({this.index, this.pattern, this.responses, this.tag});

  Intents.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    pattern = json['pattern'].cast<String>();
    responses = json['responses'].cast<String>();
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['pattern'] = this.pattern;
    data['responses'] = this.responses;
    data['tag'] = this.tag;
    return data;
  }
}
