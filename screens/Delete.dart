import 'package:flutter/material.dart';  

  
class Delete extends StatefulWidget {  
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<Delete> {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Admission staff',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Delete Data'),
              backgroundColor: Colors.red[700],
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
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Delete Index',  
                      hintText: 'Delete Index',  
                    ),  
                  ),  
                ),  
                // Padding(  
                //   padding: EdgeInsets.all(15),  
                //   child: TextField(  
                //     decoration: InputDecoration(  
                //       border: OutlineInputBorder(),  
                //       labelText: 'Delete Question',  
                //       hintText: 'Delete Question from dataset',  
                //     ),  
                //   ),  
                // ),  
                // Padding(  
                //   padding: EdgeInsets.all(15),  
                //   child: TextField(  
                //     obscureText: true,  
                //     decoration: InputDecoration(  
                //       border: OutlineInputBorder(),  
                //       labelText: 'Delete Response',  
                //       hintText: 'Enter Delete for the question',  
                //     ),  
                //   ),  
                // ),  
                //  Padding(  
                //   padding: EdgeInsets.all(15),  
                //   child: TextField(  
                //     obscureText: true,  
                //     decoration: InputDecoration(  
                //       border: OutlineInputBorder(),  
                //       labelText: 'Delete Another Response',  
                //       hintText: 'Optional',  
                //     ),  
                //   ),  
                // ),  
                // Padding(  
                //   padding: EdgeInsets.all(15),  
                //   child: TextField(  
                //     obscureText: true,  
                //     decoration: InputDecoration(  
                //       border: OutlineInputBorder(),  
                //       labelText: 'Delete Another Response',  
                //       hintText: 'Optional',  
                //     ),  
                //   ),  
                // ),  
                ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[700], // background
                          onPrimary: Colors.white, // foreground
                           minimumSize: Size(200,50),
                        ),
                        onPressed: () {},
                        child: Text('Submit'),
                      )
              ],  
            )  
        )  
    ));  
  }  
} 
