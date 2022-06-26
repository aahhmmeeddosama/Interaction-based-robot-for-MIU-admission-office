import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'add_q_a.dart';
import 'delete_q_a.dart';
import 'edit_q_a.dart';

class Admission extends StatelessWidget {
  String arabicurl = 'http://192.168.0.131:8005/';
  String englishurl = 'http://192.168.0.131:8002/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Admission staff',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red[700],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 200, 40, 40),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Access responses',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700], // background
                      onPrimary: Colors.white, // foreground
                      minimumSize: Size(200, 50),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogAdd(context);
                    },
                    child: Text('Add'),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700], // background
                      onPrimary: Colors.white, // foreground
                      minimumSize: Size(200, 50),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogEdit(context);
                    },
                    child: Text('Edit'),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700], // background
                      onPrimary: Colors.white,
                      minimumSize: Size(200, 50), // foreground
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogDelete(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>  Delete_Q_A()));
                    },
                    child: Text('Delete'),
                  )),
            ]),
          ),
        ));
  }

  showAlertDialogDelete(BuildContext context) {
    // set up the buttons
    Widget arabicButton = TextButton(
      style: TextButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      child: Text("Arabic", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Delete_Q_A(arabicurl),
          ),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Delete_Q_A(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Choose",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
              color: Colors.red[700])),
      content: Text(
        "which dataset you need to access 'Arabic' OR 'English' ",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: "Times New Roman",
        ),
      ),
      actions: [
        cancelButton,
        englishButton,
        arabicButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogAdd(BuildContext context) {
    // set up the buttons
    Widget arabicButton = TextButton(
      child: Text("Arabic", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
              curve: Curves.linear,
              type: PageTransitionType.scale,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: Add_Q_A(arabicurl)),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Add_Q_A(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Choose",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
              color: Colors.red[700])),
      content: Text(
        "which dataset you need to access 'Arabic' OR 'English' ",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: "Times New Roman",
        ),
      ),
      actions: [
        cancelButton,
        englishButton,
        arabicButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogEdit(BuildContext context) {
    // set up the buttons
    Widget arabicButton = TextButton(
      child: Text("Arabic", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Edit_Q_A(arabicurl),
          ),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Edit_Q_A(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: Colors.red[700])),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Choose",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
              color: Colors.red[700])),
      content: Text(
        "which dataset you need to access 'Arabic' OR 'English' ",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: "Times New Roman",
        ),
      ),
      actions: [
        cancelButton,
        englishButton,
        arabicButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
