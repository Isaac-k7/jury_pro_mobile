import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Candidat.dart';

class CandidatInscrit extends StatefulWidget {
  static const pageName = "ListeCandidat";
  @override
  _CandidatInscritState createState() => _CandidatInscritState();

  int idEvent;
  CandidatInscrit({this.idEvent});
}

class _CandidatInscritState extends State<CandidatInscrit> {
  List data;
  List listeCandidats;

  // Upload image var
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  Future getData(int uri) async {
    String _uri = uri.toString();
    http.Response response =
        await http.get("http://172.31.240.26:8080/candidats/event/" + _uri);
    data = json.decode(response.body);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData(widget.idEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            // var image = base64Decode(data[index]["candidat_photo"]);
            Uint8List image;
            if (data[index]["candidat_photo"] != null) {
              image = base64Decode(data[index]["candidat_photo"]);
            }

            return Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Center(
                        //listes des evenements
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            elevation: 5.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    child: data[index]["candidat_photo"] != null
                                        ? Image.memory(image)
                                        : Text(''),
                                  )),
                              title: Text(
                                "${data[index]["candidat_nom"]} ${data[index]["candidat_prenom"]}",
                              ),
                              subtitle:
                                  Text('Code: ${data[index]["candidat_code"]}'),
                              onTap: (){
                                Text('Another data');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Candidat(
                                        id: "${data[index]["candidat_id"]}",
                                      ),
                                    ));
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

void editListeCandidat() {}
