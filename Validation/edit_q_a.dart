import 'package:flutter/material.dart';

import 'API.dart';

class Edit_Q_A extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Edit_Q_A> {
  var formKey = GlobalKey<FormState>();

  @override
  String url = 'http://192.168.1.11:8003/';
  String? t;
  var Data;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit to flutter'),
          backgroundColor: Color.fromARGB(255, 189, 14, 14),
        ),
        body: Form(
            key: formKey,
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
                  padding: const EdgeInsets.fromLTRB(30, 10, 50, 20),
                  child: Image.asset('assets/images/logo_miu.png'),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.number, //keyboard bytft7 3ala numbers
                      controller: myController1,
                      decoration: InputDecoration(
                          hintText: 'Add index',
                          labelText: 'Add index',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add Index';
                        } else if (value.length > 3) {
                          return 'Max 3 characters';
                        } else {
                          return null;
                        }
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.text, //keyboard bytft7 3ala numbers
                      controller: myController2,
                      decoration: InputDecoration(
                          hintText: 'Edit Question',
                          labelText: 'Edit Question',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Edit Question';
                        } else if (!value.contains("*")) {
                          return 'Must contain *';
                        } else {
                          return null;
                        }
                      },
                    )),
//                   TextField(
//                     controller: myController2,

// //                      url +='&tag=' + value.toString();
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'tag',
//                       hintText: 'Edit Question',
//                     ),
//                   ),
//                 ),

                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.text, //keyboard bytft7 3ala numbers
                      controller: myController3,
                      decoration: InputDecoration(
                          hintText: 'Pattern',
                          labelText: 'Enter answer for the question',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter answer for the question';
                        } else if (!value.contains("*")) {
                          return 'Must contain *';
                        } else {
                          return null;
                        }
                      },
                    )),

//                    TextField(
//                     controller: myController3,
// //url +='&pattern=' + value.toString();
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'pattern',
//                       hintText: 'Enter answer for the question',
//                     ),
//                   ),
                // ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.text, //keyboard bytft7 3ala numbers
                      controller: myController4,
                      decoration: InputDecoration(
                          hintText: 'Optional',
                          labelText: 'Write response (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      // validator: (value) { //optional can be empty 3ady
                      //   if (value == null || value.isEmpty) {
                      //     return null;
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    )),

                //   TextField(
                //     controller: myController4,
                //     //                      url +='&response=' + value.toString()+'&context=kllk';
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Write response',
                //       hintText: 'Optional',
                //     ),
                //   ),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700], // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(120, 50),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      myController1;
                      myController2;
                      myController3;
                      myController4;
                      String URLL = url +
                          'edit?edit=' +
                          myController1.text +
                          '&tag=' +
                          myController2.text +
                          '&pattern=' +
                          myController3.text +
                          '&response=' +
                          myController4.text +
                          '&context=kllkj';
                      Data = await Getdata(URLL);
                      myController1.clear();
                      myController2.clear();
                      myController3.clear();
                      myController4.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      return setState(() {});

                      /*setState(() {
                      QueryText = Data['delete'] ;
                    });*/
                    }
                  },
                  child: Text('Submit', style: TextStyle(fontSize: 20)),
                )
              ],
            )));
  }
}
