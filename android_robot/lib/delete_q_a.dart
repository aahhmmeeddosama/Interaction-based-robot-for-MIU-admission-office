import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';

  
class Delete_Q_A extends StatefulWidget {
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<Delete_Q_A> {
  @override
  String? url;
  var Data;
  String QueryText = 'delete';

  Widget build(BuildContext context) {  
    return Scaffold(  
        appBar: AppBar(  
          title: Text('Delete to flutter'),  
        ),  
        body: Padding(
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                 Text(
                    'Delete Question',
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
                    onChanged: (value) {
                      url = 'http://192.168.1.11:8003/bot?delete=' + value.toString();
                    },

                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Delete tag',  

                    ),  
                  ),  
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    QueryText,
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),/////////////

                ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                           minimumSize: Size(200,50),
                        ),
                        onPressed: () async {
                          Data = await Getdata(url);

                          setState(() {
                            QueryText = Data['delete'] ;
                          });
                        },

                        child: Text('Submit'),
                      )
              ],
            )
        ) ,

    );  
  }  
} 
