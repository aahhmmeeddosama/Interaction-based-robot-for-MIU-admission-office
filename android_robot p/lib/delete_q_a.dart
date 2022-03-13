import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';

  
class Delete_Q_A extends StatefulWidget {
  String URL;
  Delete_Q_A(this.URL);

  @override  
  _State createState() => _State(URL);
}  
  
class _State extends State<Delete_Q_A> {
  var formKey = GlobalKey<FormState>();

  @override
  String URL;
  String? url;
  var Data;
  String QueryText = 'delete';



  _State(this.URL);

  Widget build(BuildContext context) {  
    return Scaffold(  
        appBar: AppBar(
          centerTitle: true,
          title: Text('Delete Question'),
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
                        'enter questions\' index to delete',
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
                        onChanged: (value) {
                          url = URL+'bot?delete=' + value.toString();
                        },
                        keyboardType:
                        TextInputType.number, //keyboard bytft7 3ala numbers
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),
                            borderSide:  BorderSide(color: Colors.red ),),
                          labelText: 'Delete index',
                          hintText: 'ُEnter index',
                            labelStyle: TextStyle(
                              color: Colors.red[700],
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
                                  Data = await Getdata(url);

                                  setState(() {
                                    QueryText = Data['delete'];
                                  });
                                }
                              },

                              child: Text('Submit'),
                            ),
                    )
                  ],
                )
            ),
          ),
        ) ,

    );  
  }  
} 
