import 'dart:typed_data';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

// ignore: must_be_immutable
class CandidatInscrit extends StatefulWidget {
  static const pageName = "ListeCandidat";

  @override
  _CandidatInscritState createState() => _CandidatInscritState();

  var idEvent;
  CandidatInscrit({this.idEvent});
}

class _CandidatInscritState extends State<CandidatInscrit> {
  List data;
  List critereData;
  List listeCandidats;
  // Upload image var
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  Future getData(var uri) async {
    String _uri = uri.toString();
    http.Response response =
        await http.get("http://172.31.240.26:8080/candidats/event/" + _uri);
    data = json.decode(response.body);
    setState(() {
      data = data;
    });
  }

  Future getEventData(var uri) async {
    String _uri = uri.toString();
    http.Response response =
        await http.get("http://172.31.240.26:8080/candidats/event/" + _uri);
    critereData = json.decode(response.body);
    setState(() {
      critereData = critereData;
    });
  }

  @override
  void initState() {
    super.initState();

    getData(widget.idEvent);
    getEventData(widget.idEvent);
  }

  double points = 0;
  double points2 = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              // var image = base64Decode(data[index]["candidat_photo"]);
              Uint8List image;
              if (data[index]["candidat_photo"] != null) {
                image = base64Decode(data[index]["candidat_photo"]);
              }
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  //
                                ),
                                height: 600,
                                width: 350,
                                child: Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text(
                                              "Code : ${data[index]["candidat_code"]}",
                                              style: TextStyle(
                                                  color: Colors.orange[700],
                                                  fontSize: 24)),
                                          Text(''),
                                          Container(
                                            height: 200,
                                            width: 200,
                                            child: data[index]
                                                        ["candidat_photo"] !=
                                                    null
                                                ? Image.memory(image)
                                                : Image.asset(
                                                    "assets/images/icons8-administrateur-homme-96.png"),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          Text(''),
                                          Text(
                                              "${data[index]["candidat_nom"]} ${data[index]["candidat_prenom"]}",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 24)),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                        'Performance : ' +
                                                            points.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16))),
                                                SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRatingChanged: (value) {
                                                    setState(() {
                                                      points = value;
                                                    });
                                                  },
                                                  starCount: 5,
                                                  rating: points,
                                                  size: 30.0,
                                                  color: Colors.orange[300],
                                                  borderColor:
                                                      Colors.orange[300],
                                                  spacing: 0.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                        'Performance : ' +
                                                            points2.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16))),
                                                SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRatingChanged: (value2) {
                                                    setState(() {
                                                      points2 = value2;
                                                    });
                                                  },
                                                  starCount: 5,
                                                  rating: points2,
                                                  size: 30.0,
                                                  color: Colors.blue[300],
                                                  borderColor: Colors.blue[300],
                                                  spacing: 0.0,
                                                ),
                                              ],
                                            ),
                                          )
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
                                                                        index][
                                                                    "candidat_id"],
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
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void editListeCandidat() {}

// user defined function
