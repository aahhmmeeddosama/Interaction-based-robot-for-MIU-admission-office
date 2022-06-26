import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HH extends StatefulWidget {
  const HH({Key? key}) : super(key: key);

  @override
  State<HH> createState() => _HHState();
}

class _HHState extends State<HH> {
  http.Client getClient() {
    return http.Client();
  }

  String a = "";

  String? getResponse() {
    if (true) {
      var client = getClient();
      try {
        client
            .get(
          Uri.parse('http://192.168.0.131:5000/chats'),
        )
            .then((response) {
          print(response.body);
          var data = response.body;

          setState(() {
            a = data.toString();
          });
          return a;
        });
      } finally {}
    }
  }

  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    //   int idx = a.indexOf(":");
    //   List parts = [a.substring(0,idx).trim(), a.substring(idx+1).trim()];
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text('Edit Question'),
    //       backgroundColor: Colors.red[700],
    //     ),
    //     body: SingleChildScrollView(
    //         child: Column(
    //       children: [
    //         Text(getResponse().toString()),
    //         Text(a),
    //       ],
    //     )),
    //   );
    // }
  }
}
