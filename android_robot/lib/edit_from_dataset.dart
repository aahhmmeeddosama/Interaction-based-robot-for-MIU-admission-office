import 'package:flutter/material.dart';
import 'constants/app_color.dart';
import 'API.dart';

class EditFromDataset extends StatefulWidget {
  String URL;
  EditFromDataset(this.URL);
  @override
  _State createState() => _State(URL);
}

class _State extends State<EditFromDataset> {
  String URL;
  String? url;
  String? t;
  var Data;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  var formKey = GlobalKey<FormState>();

  _State(this.URL);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Question', style: TextStyle(fontSize: 30)),
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
                      'Enter questions\' index then edited data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: MyColors.myBlack,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: myController1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: MyColors.myRed),
                          ),
                          labelText: 'Index',
                          hintText: 'Write Index',
                          labelStyle: TextStyle(
                            color: MyColors.myBlack,
                            fontSize: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add Index';
                          } else if (value.length > 3) {
                            return 'Max 3 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: myController2,
//                      url +='&tag=' + value.toString();
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelText: 'Tag',
                          hintText: 'Edit Tag',
                          labelStyle: TextStyle(
                            color: MyColors.myBlack,
                            fontSize: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add edited Tag';
                          } else if (value.length > 3) {
                            return 'Max 3 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: myController3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: MyColors.myRed),
                          ),
                          labelText: 'Pattern',
                          hintText: 'Edit Pattern',
                          labelStyle: TextStyle(
                            color: MyColors.myBlack,
                            fontSize: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add edited Pattern';
                          } else if (!value.contains("*")) {
                            return 'Must contain *';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: myController4,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: MyColors.myRed),
                          ),
                          labelText: 'Response',
                          hintText: 'add Response',
                          labelStyle: TextStyle(
                            color: MyColors.myBlack,
                            fontSize: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add edited Response';
                          } else if (!value.contains("*")) {
                            return 'Must contain *';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MyColors.myRed, // background
                          onPrimary: MyColors.myWhite, // foreground
                          minimumSize: Size(200, 70),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            myController1;
                            myController2;
                            myController3;
                            myController4;
                            String url = URL +
                                'edit?edit=' +
                                myController1.text +
                                '&tag=' +
                                myController2.text +
                                '&pattern=' +
                                myController3.text +
                                '&response=' +
                                myController4.text +
                                '&context=kllkj';
                            Data = await Getdata(url);
                            myController1.clear();
                            myController2.clear();
                            myController3.clear();
                            myController4.clear();
                            return setState(() {});
                            /*setState(() {
                            QueryText = Data['delete'] ;
                          });*/
                          }
                        },
                        child: Text('Submit', style: TextStyle(fontSize: 30)),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
