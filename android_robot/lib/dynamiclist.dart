import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  List<String> litems = [];
  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dynamic Demo"),
        ),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {});
              },
            ),
            new Expanded(
                child: new ListView.builder(
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return new Text(litems[Index]);
                    }))
          ],
        ));
  }
}
