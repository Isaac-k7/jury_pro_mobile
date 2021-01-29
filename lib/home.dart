import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  static const pageName = "Evenement";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String item = "evenements";
  List data;
  List evenements;
  Future getData(String uri) async {
    String _uri = uri;
    http.Response response =
        await http.get("http://172.31.242.104:8080/" + _uri);
    data = json.decode(response.body);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData(item);
  }

  Future deleteEvenement(String uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.242.104:8080/evenements/delete/' + _uri));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(onPressed: (){}, child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Icon(Icons.event_note,size: 100, color: Colors.orange[700],),
                  ),),
                  FlatButton(onPressed: (){}, child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Icon(Icons.verified,size: 100, color: Colors.orange[700],),
                  ),),
                ],
              ),
          ),
       
        ],
      ),
    );
  }
}

void editEvenement() {}
