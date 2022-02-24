import 'package:flutter/material.dart';  

  
class Add extends StatefulWidget {  
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<Add> {  
  @override  
  Widget build(BuildContext context) {  
   return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Admission staff',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Add Data'),
              backgroundColor: Colors.red[700],
            ),
        body: Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                 Text(
                    'Add New Question',
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
                      labelText: 'Add tag',  
                      hintText: 'Add Tag',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Add Question',  
                      hintText: 'Add new question to dataset',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Add Response',  
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
                      labelText: 'Add Another Response',  
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
                      labelText: 'Add Another Response',  
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



// import 'package:flutter/material.dart';

// class Add extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Admission staff',
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Add to dataset'),
//             ),
//             body: Center(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
//                 child: Column(children: [
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       border: UnderlineInputBorder(),
//                       labelText: 'Enter your username',
//                     ),
//                   ),
//                 ]),
//               ),
//             )));
//   }
// }
