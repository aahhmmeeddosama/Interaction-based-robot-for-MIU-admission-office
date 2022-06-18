import 'package:android_robot/constants/app_color.dart';
import 'package:android_robot/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'add_to_dataset.dart';
import 'delete_from_dataset.dart';
import 'edit_from_dataset.dart';

class AdmissionSide extends StatelessWidget {
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
              fontSize: 30,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: MyColors.myRed,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 100, 40, 40),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Access responses',
                  style: TextStyle(
                    fontSize: 50,
                    color: MyColors.myBlack,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myRed, // background
                      onPrimary: MyColors.myWhite,
                      minimumSize: Size(200, 70), // foreground
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoScreen()));
                    },
                    child:
                        Text('Add New Admin', style: TextStyle(fontSize: 30)),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myRed, // background
                      onPrimary: MyColors.myWhite, // foreground
                      minimumSize: Size(200, 70),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogAdd(context);
                    },
                    child: Text('Add', style: TextStyle(fontSize: 30)),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myRed, // background
                      onPrimary: MyColors.myWhite, // foreground
                      minimumSize: Size(200, 70),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogEdit(context);
                    },
                    child: Text('Edit', style: TextStyle(fontSize: 30)),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myRed, // background
                      onPrimary: MyColors.myWhite,
                      minimumSize: Size(200, 70), // foreground
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      showAlertDialogDelete(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>  Delete_Q_A()));
                    },
                    child: Text('Delete', style: TextStyle(fontSize: 30)),
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
      child: Text("Arabic", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: DeleteFromDataset(arabicurl),
          ),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: DeleteFromDataset(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: MyColors.myRed)),
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
          color: MyColors.myBlack,
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
      child: Text("Arabic", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
              curve: Curves.linear,
              type: PageTransitionType.scale,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: AddToDataset(arabicurl)),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: AddToDataset(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: MyColors.myRed)),
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
          color: MyColors.myBlack,
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
      child: Text("Arabic", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: EditFromDataset(arabicurl),
          ),
        );
      },
    );
    Widget englishButton = TextButton(
      child: Text("English", style: TextStyle(color: MyColors.myRed)),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: EditFromDataset(englishurl),
          ),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: MyColors.myRed)),
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
          color: MyColors.myBlack,
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
