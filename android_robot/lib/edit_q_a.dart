import 'package:flutter/material.dart';

import 'API.dart';
  
class Edit_Q_A extends StatefulWidget {
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<Edit_Q_A> {
  @override

  String url='http://192.168.1.11:8003/';
  String? t;
  var Data;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();



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
          title: Text('Edit to flutter'),
        ),  
        body: Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                 Text(
                    'Edit Question',
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
                      border: OutlineInputBorder(),  
                      labelText: 'Index',
                      hintText: 'Add',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(
                    controller: myController2,

//                      url +='&tag=' + value.toString();
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Tag',
                      hintText: 'Edit Question',
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(
                    controller: myController3,
//url +='&pattern=' + value.toString();
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Pattern',
                      hintText: 'Enter answer for the question',  
                    ),  
                  ),  
                ),  
                 Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(
                    controller: myController4,
                    //                      url +='&response=' + value.toString()+'&context=kllk';
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Response',
                      hintText: 'Optional',  
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
                          myController4;
                          String URLL = url+ 'edit?edit='+myController1.text+'&tag='+myController2.text+'&pattern='+myController3.text+'&response='+myController4.text+'&context=kllkj';
                    Data = await Getdata(URLL);
                    myController1.clear();
                    myController2.clear();
                    myController3.clear();
                    myController4.clear();


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