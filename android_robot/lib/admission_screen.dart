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
              backgroundColor: Color.fromARGB(255, 189, 14, 14), 
            ),
            body: ListView(
              children: [
                Padding(
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
            padding: const EdgeInsets.fromLTRB(30, 10, 50, 20),
            child: Image.asset('assets/images/logo_miu.png'),
          ),
          SizedBox(height: 80,),
                  Row(
                    children: [
                      SizedBox(width: 80,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(200,50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                           Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Add',style: TextStyle(fontSize: 20),),
                      ),
                      SizedBox(width: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                          minimumSize: Size(200,50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(_createRoute2());
                        },
                        child: Text('Edit',style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white,
                          minimumSize: Size(200,50),// foreground
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(_createRoute3());
                        },
                        child: Text('Delete',style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  
                  
                ]),
              ), 
              ],
            ),
            );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const  Add_Q_A(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Edit_Q_A(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute3() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  Delete_Q_A(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
