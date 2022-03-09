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
          backgroundColor: Color.fromARGB(255, 189, 14, 14), 
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
            padding: const EdgeInsets.fromLTRB(30, 10, 50, 20),
            child: Image.asset('assets/images/logo_miu.png'),
          ),
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(
                    onChanged: (value) {
                      url = 'http://192.168.1.11:8003/bot?delete=' + value.toString();
                    },

                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'write the tag that you want to delete',  

                    ),  
                  ),  
                ),

                ElevatedButton(
                  
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                           minimumSize: Size(200,50),
                           shape: StadiumBorder(),
                           
                        ),
                        onPressed: () async {
                          Data = await Getdata(url);

                          setState(() {
                            QueryText = Data['delete'] ;
                          });
                        },

                        child: Text('Delete',style: TextStyle(fontSize: 20)),
                      )
              ],
            )
        ) ,
    );  
  }  
} 
