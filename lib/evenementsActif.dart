import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '_main.dart';
import 'candidatsInscrit.dart';
import 'newUpdate.dart';

class EvenementsActif extends StatefulWidget {
  static const pageName = "EvenementsActif";
  @override
  _EvenementsActifState createState() => _EvenementsActifState();
}

class _EvenementsActifState extends State<EvenementsActif> {
  String item = "evenements";
  List data;
  List evenementsActifs;

  // Upload image var
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

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

  chooseImage() {
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Future deleteEvenementsActif(String uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.240.26:8080/evenements/delete/' + _uri));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.orange[700]),
        title: Center(
            child: new Text('Nouvel evenement',
                style: TextStyle(color: Colors.orange[700], fontSize: 25))),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                var image = base64Decode("${data[index]["images"]}");
                return Column(
                  children: <Widget>[
                    Text(''),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: <Widget>[
                          Center(
                            //listes des evenementsActifs
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 10.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //
                                  ),
                                  height: 500,
                                  width: 300,
                                  child: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Icon(
                                                  Icons.event_note,
                                                  size: 30,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                    "${data[index]["nom"]}",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.orange[700],
                                                        fontSize: 24)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 300,
                                              width: 200,
                                              child: Image.memory(image),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            Text("${data[index]["type"]}",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                                "Début: ${data[index]["dateDebut"]}",
                                                style: TextStyle(
                                                    color: Colors.orange[700],
                                                    fontSize: 11)),
                                            Text(
                                                "Fin: ${data[index]["dateFin"]}",
                                                style: TextStyle(
                                                    color: Colors.orange[700],
                                                    fontSize: 11)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  // color: Colors.blue,
                                                ),
                                                child: FlatButton(
                                                  child: Text('Candidats'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CandidatInscrit(
                                                                  idEvent: data[
                                                                          index]
                                                                      ["id"],
                                                                )));
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  // color: Colors.blue,
                                                ),
                                                child: FlatButton(
                                                  child: Text('Critères'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CandidatInscrit()));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
        ),
      ),
    );
  }
}

void editevenementsActif() {}
