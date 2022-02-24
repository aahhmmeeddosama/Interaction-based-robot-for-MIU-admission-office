import 'package:flutter/material.dart';
import 'package:sdd_frontend/Staff.dart';

import 'Add.dart';

class Welcome_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Column(
            children: [
              Image.asset('assets/welcome.png',
                  height: 350, width: 380, fit: BoxFit.fitWidth),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  'Welcome on MIU!',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontFamily: "arial",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  'If you are an applicant',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontFamily: "arial",
                  ),
                ),
              ),
              Text(
                ' say:  "HI ROBOT هاى روبوت"',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "arial",
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/Tone.png',
                    height: 100, width: 410, fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  'From staff',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontFamily: "arial",
                  ),
                ),
              ),
              Text(
                ' say: "STAFF"',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "arial",
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 10, 10, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700], // background
                      onPrimary: Colors.white, // foreground
                      // minimumSize: Size(200, 50),
                    ),
                    onPressed: () {},
                    child: Text('Student'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700], // background
                      onPrimary: Colors.white, // foreground
                      // minimumSize: Size(200, 50),
                    ),
                    onPressed: () {},
                    child: Text('Staff'),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
