import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data;
  List evenements;
  Future getData() async {
    http.Response response =
        await http.get("http://172.31.242.104:8080/evenements");

    data = json.decode(response.body);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text(
                      'Evenement',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.grey,
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return myWidget(data, index);
                      }),
                ),
              ),
            ],
          )),
    );
  }
}

//replace with example code above
Widget myWidget(_data, _index) {
  var data = _data;
  var index = _index;
  return Row(
    children: <Widget>[
      Expanded(
        flex: 7,
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
          //   color: Colors.white,
          //   border: Border(
          //     left: BorderSide(
          //       color: Colors.green,
          //       width: 3,
          //     ),
          //   ),
          // ),
          child: Column(
            children: <Widget>[
              Center(
                //listes des evenements
                child: Card(
                  elevation: 10.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("${data[index]["nom"]}"),
                        subtitle: Text("${data[index]["type"]}"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "${data[index]["dateDebut"]}",
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${data[index]["dateFin"]}",
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          child: Center(
              child: Text(
            "Evenement",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
          color: Colors.white,
        ),
      ),
    ],
  );
}
