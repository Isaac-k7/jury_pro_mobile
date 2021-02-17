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

class Evenement extends StatefulWidget {
  static const pageName = "Evenement";
  @override
  _EvenementState createState() => _EvenementState();
}

class _EvenementState extends State<Evenement> {
  String item = "evenements";
  List data;
  List evenements;
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

  //upload image

//   startUpload() {
//   setStatus('Uploading Image...');
//   if (null == tmpFile) {
//     setStatus(errMessage);
//     return;
//   }
//   String fileName = tmpFile.path.split('/').last;
//   upload(fileName);
// }

// upload(String fileName) {
//   http.post(uploadEndPoint, body: {
//     "image": base64Image,
//     "name": fileName,
//   }).then((result) {
//     setStatus(result.statusCode == 200 ? result.body : errMessage);
//   }).catchError((error) {
//     setStatus(error);
//   });
// }

  Future deleteEvenement(String uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.242.26:8080/evenements/delete/' + _uri));
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
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Center(
                        //listes des evenements
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
                                            child: Image.asset(
                                              "images/orange.png",
                                              fit: BoxFit.cover,
                                              height: 30,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text("${data[index]["nom"]}",
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
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg"),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Text("${data[index]["type"]}",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("Début: ${data[index]["dateDebut"]}",
                                            style: TextStyle(
                                                color: Colors.orange[700],
                                                fontSize: 11)),
                                        Text("Fin: ${data[index]["dateFin"]}",
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
                                                    builder: (_) =>
                                                        CupertinoAlertDialog(
                                                          title: Text(
                                                              "Etes-vous sûr de vouloir supprimer cet evenement?"),
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
                                                                this.deleteEvenement(
                                                                    "${data[index]["id"]}"
                                                                        .toString());
                                                                print(
                                                                    "${data[index]["id"]}");
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                setState(() {});
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
                                                showCupertinoDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        CupertinoAlertDialog(
                                                          title: Text(
                                                              "This is the title"),
                                                          content: Text(
                                                              "This is the content"),
                                                          actions: [
                                                            // Close the dialog

                                                            CupertinoButton(
                                                              child: Text("OUI",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .orange[
                                                                          900])),
                                                              onPressed: () {
                                                                this.deleteEvenement(
                                                                    "${data[index]["id"]}"
                                                                        .toString());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                setState(() {});
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

void editEvenement() {}
