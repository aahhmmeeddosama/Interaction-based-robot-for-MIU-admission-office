import 'package:flutter/material.dart';

import 'api.dart';

class Add_Q_A extends StatefulWidget {
  const Add_Q_A({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Add_Q_A> {
  @override

  String url='http://192.168.1.11:8003/';
  String? t;
  var Data;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();



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
          title: Text('Add to flutter'),
          backgroundColor: Colors.red[700],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Text(
                  'Add Question',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontFamily: "arial",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: myController1,


                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                        borderSide:  BorderSide(color: Colors.red ),),                      labelText: 'Tag',
                      hintText: 'Add Tag',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: myController3,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                        borderSide:  BorderSide(color: Colors.red ),),                      labelText: 'Response',
                      hintText: 'Enter answer for the question',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700], // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(200,50),
                  ),
                  onPressed: () async {
                    myController1;
                    myController2;
                    myController3;
                    String URLL = url+ 'add?tag='+myController1.text+'&patterns='+myController2.text+'&responses='+myController3.text;
                    Data = await Getdata(URLL);
                    myController1.clear();
                    myController2.clear();
                    myController3.clear();


                    return setState(() {});

                    /*setState(() {
                      QueryText = Data['delete'] ;
                    });*/
                  },
                  child: Text('Submit'),
                )
              ],
            )
        )
    );
  }
}