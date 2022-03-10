import 'package:flutter/material.dart';
import 'package:sdd_frontend/Staff.dart';
import 'package:sdd_frontend/Add.dart';

import 'Edit.dart';
import 'Welcome_screen.dart';
import 'Delete.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIU ADMISSION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: Welcome_screen(),
      // home: Staff(),
      // home:Edit(),
      //  home: Delete(),
    );
  }
}
