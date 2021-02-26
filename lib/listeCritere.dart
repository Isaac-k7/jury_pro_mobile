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
import 'newUpdate.dart';

class Critere extends StatefulWidget {
  static const pageName = "critere";
  @override
  _CritereState createState() => _CritereState();
}

class _CritereState extends State<Critere> {
  String item = "criteres";
  List data;
  List criteres;

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

  Future deletecritere(String uri) async {
    String _uri = uri;

    var request = http.Request(
        'POST', Uri.parse('http://172.31.240.26:8080/criteres/delete/' + _uri));
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
            var image = base64Decode("${data[index]["images"]}");
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Center(
                        //listes des criteres
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
                              height: 200,
                              width: 250,
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
                                                "${data[index]["criteres_libelle"]}",
                                                style: TextStyle(
                                                    color: Colors.orange[700],
                                                    fontSize: 24)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 100,
                                          // child: Image.memory(image),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text(
                                            "Barèms : ${data[index]["candidat_bareme"]}",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                            "Début: ${data[index]["detail"]}",
                                            style: TextStyle(
                                                color: Colors.orange[700],
                                                fontSize: 11)),
                                        Text(
                                            "Fin: ${data[index]["criteres_id"]}",
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
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              // color: Colors.blue,
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                              onPressed: () {
                                                showCupertinoDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CupertinoAlertDialog(
                                                          title: Text(
                                                              "Etes-vous sûr de vouloir supprimer cet critere?"),
                                                          // content: Text(
                                                          //     "This is the content"),
                                                          actions: [
                                                            // Close the dialog
                                                            CupertinoButton(
                                                              child: Text("OUI",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .orange[
                                                                          900])),
                                                              onPressed: () {
                                                                this.deletecritere(
                                                                    "${data[index]["id"]}"
                                                                        .toString());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MyApp()));
                                                              },
                                                            ),
                                                            CupertinoButton(
                                                                child: Text(
                                                                    'NON',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange[900])),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                })
                                                          ],
                                                        ));
                                              },
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              // color: Colors.red,
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.green,
                                              onPressed: () {
                                                print('non implémenter');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewUpdateEvent(
                                                        id: "${data[index]["id"]}",
                                                      ),
                                                    ));
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
    );
  }
}

void editcritere() {}
