import 'package:android_robot/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'API.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteFromDataset extends StatefulWidget {
  String URL;
  DeleteFromDataset(this.URL);

  @override
  _State createState() => _State(URL);
}

class _State extends State<DeleteFromDataset> {
  var formKey = GlobalKey<FormState>();
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    Uri myURI = Uri.parse('http://192.168.0.131:8002/bot/view');

    final http.Response response = await http.get(myURI);
    final data = await json.decode(response.body);
    setState(() {
      _items = data["intents"];
    });
  }

  hideData() {
    setState(() {
      _items = [];
    });
  }

  String URL;
  String? url;
  var Data;
  String QueryText = 'delete';
  _State(this.URL);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Delete Question', style: TextStyle(fontSize: 30)),
        backgroundColor: MyColors.myRed,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
              padding: EdgeInsets.fromLTRB(40, 80, 40, 80),
              child: Column(
                children: <Widget>[
                  Text(
                    'Enter questions\' index to delete',
                    style: TextStyle(
                      fontSize: 30,
                      color: MyColors.myBlack,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: TextFormField(
                      onChanged: (value) {
                        url = URL + 'bot?delete=' + value.toString();
                      },
                      keyboardType:
                          TextInputType.number, //keyboard bytft7 3ala numbers
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: MyColors.myRed)),
                        labelText: 'Delete index',
                        hintText: 'ُEnter index',
                        labelStyle: TextStyle(
                          fontSize: 30,
                          color: MyColors.myRed,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please write Index that you want to delete';
                        } else if (value.length > 3) {
                          return 'Minimum 3 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: MyColors.myRed, // background
                        onPrimary: MyColors.myWhite, // foreground
                        minimumSize: Size(200, 70),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Data = await Getdata(url);
                          setState(() {
                            QueryText = Data['delete'];
                          });
                        }
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 160),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 150, 80, 150),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.myRed, // background
                              onPrimary: MyColors.myWhite, // foreground
                              minimumSize: Size(0, 50),
                              shape: StadiumBorder(),
                            ),
                            child: const Text('Load Data',
                                style: TextStyle(fontSize: 20)),
                            onPressed: readJson,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 180),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.myRed, // background
                              onPrimary: MyColors.myWhite,
                              minimumSize: Size(0, 50), // foreground
                              shape: StadiumBorder(),
                            ),
                            child: const Text('Hide Data',
                                style: TextStyle(fontSize: 20)),
                            onPressed: hideData,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: _items.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.all(8),
                                    child: ListTile(
                                      leading: Text("index: " +
                                          _items[index]["index"].toString()),
                                      title: Text(
                                          _items[index]["pattern"].toString()),
                                      subtitle: Text(_items[index]["responses"]
                                          .toString()),
                                      trailing:
                                          Text(_items[index]["tag"].toString()),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container()),
                ],
              )),
        ),
      ),
    );
  }
}
