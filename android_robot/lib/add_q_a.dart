import 'package:flutter/material.dart';

import 'api.dart';

class Add_Q_A extends StatefulWidget {
  String URL;
  Add_Q_A(this.URL);
  @override
  _State createState() => _State(URL);
}

class _State extends State<Add_Q_A> {
  var formKey = GlobalKey<FormState>();

  @override
  String URL;
  String? url;
  String? t;
  var Data;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  _State(this.URL);



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Question'),
          backgroundColor: Colors.red[700],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Add new Question',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: myController1,


                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                            borderSide:  BorderSide(color: Colors.red ),),
                          labelText: 'Tag',
                          hintText: 'Add Tag',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Add Tag';
                          } else if (value.length < 3) {
                            return 'Minimum 3 characters';
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
                          focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                            borderSide:  BorderSide(color: Colors.red ),),
                          labelText: 'Pattern',
                          hintText: 'Add Pattern',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Add Question';
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
                        controller: myController3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                            borderSide:  BorderSide(color: Colors.red ),),                      labelText: 'Response',
                          hintText: 'Enter answer for the question',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Add Question';
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
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(200,50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            myController1;
                            myController2;
                            myController3;
                            String url = URL +
                                'add?tag=' +
                                myController1.text +
                                '&patterns=' +
                                myController2.text +
                                '&responses=' +
                                myController3.text;
                            Data = await Getdata(url);
                            myController1.clear();
                            myController2.clear();
                            myController3.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            return setState(() {});

                            /*setState(() {
                            QueryText = Data['delete'] ;
                          });*/
                          }
                        },
                        child: Text('Submit'),
                      ),
                    )
                  ],
                )
            ),
          ),
        )
    );
  }
}