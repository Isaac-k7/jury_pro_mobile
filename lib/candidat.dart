import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

class Candidat extends StatefulWidget {
  static const pageName = "Candidat";
  @override
  _CandidatState createState() => _CandidatState();
}

class _CandidatState extends State<Candidat> {
  String item = "candidats";
  List data;
  List candidats;
  Future getData(String uri) async {
    String _uri = uri;
    http.Response response =
        await http.get("http://172.31.240.26:8080/" + _uri);
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

  Future deleteCandidat(String uri) async {
    String _uri = uri;

    var request = http.Request(
        'POST', Uri.parse('http://172.31.240.26:8080/candidats' + _uri));
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
      child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            var  blob = data[index]["image"];
            var image = base64Decode(
                "YmzDpWLDpnJncsO4ZAo=");
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Center(
                        //listes des evenements
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    child: Image.memory(image),
                                  )),
                              title: Text(
                                "${data[index]["candidat_nom"]} ${data[index]["candidat_prenom"]}",
                              ),
                              subtitle:
                                  Text('Code: ${data[index]["candidat_code"]}'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Text('Another data');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

void editEvenement() {}
