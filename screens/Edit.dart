import 'package:flutter/material.dart';  

  
class Edit extends StatefulWidget {  
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<Edit> {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Admission staff',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Edit Data'),
              backgroundColor: Colors.red[700],
            ),
        body: Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                 Text(
                    'Edit Question',
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
                      labelText: 'Add Index of old question',  
                      hintText: 'Add Index',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Edit Question',  
                      hintText: 'Edit Question',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Edit Responsee',  
                      hintText: 'Enter answer for the question',  
                    ),  
                  ),  
                ),  
                 Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Edit Response',  
                      hintText: 'Optional',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Edit Response',  
                      hintText: 'Optional',  
                    ),  
                  ),  
                ),  
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