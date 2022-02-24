import 'package:flutter/material.dart';

class Staff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Admission staff',
        home: Scaffold(
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
                        child: Text('Delete'),
                      )),
                ]),
              ),
            )));
  }
}
