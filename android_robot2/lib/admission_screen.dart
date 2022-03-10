import 'package:flutter/material.dart';

import 'add_q_a.dart';
import 'delete_q_a.dart';
import 'edit_q_a.dart';

class Admission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text('Admission staff'),
              backgroundColor: Colors.red[700],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                child: Column(children: [
                  Text(
                    'Access responses',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontFamily: "arial",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(200,50),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  Add_Q_A()));
                        },
                        child: Text('Add'),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(200,50),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  Edit_Q_A()));
                        },
                        child: Text('Edit'),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white,
                          minimumSize: Size(200,50),// foreground
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  Delete_Q_A()));
                        },
                        child: Text('Delete'),
                      )),
                ]),
              ),
            ));
  }
}
