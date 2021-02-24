import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jury_pro/evenement.dart';

import '_main.dart';

class NewUpdateEvent extends StatefulWidget {
  @override
  _NewUpdateEventState createState() => new _NewUpdateEventState();

  var id;
  NewUpdateEvent({this.id});
}

class _NewUpdateEventState extends State<NewUpdateEvent> {
  String phpMsg;
  String regInfo;
  DateTime selectedDateDebut, selectedDateFin;
  var data;
  List evenements;

  // Upload image var
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String name;
  String leType;
  String debut;
  String fin;
  String tester = 'mytest';

  TextEditingController nom = new TextEditingController();
  TextEditingController type = new TextEditingController();

  // TextEditingController dateDebut = new TextEditingController();
  // TextEditingController dateFin = new TextEditingController();
  // DateTime dateDebut;
  // DateTime dateFin;

  Future getData(var uri) async {
    String _uri = uri.toString();
    http.Response response =
        await http.get("http://172.31.240.26:8080/evenements/" + _uri);
    data = json.decode(response.body);

    setState(() {
      data = data;
    });
    if (widget.id != null) {
      nom.text = data['nom'];
      type.text = data['type'];
    }
  }

  @override
  void initState() {
    super.initState();
    getData(widget.id);
  }

  sendData() async {
    var headers = {'Content-Type': 'application/json'};
    var varId = widget.id;
    var request =
        http.Request('POST', Uri.parse('http://172.31.240.26:8080/evenements'));
    request.body = '''{
      "id": "$varId",
      "nom": "${nom.text}" ,
      "type": "${type.text}" ,
      "dateDebut": "$selectedDateDebut",
      "dateFin": "$selectedDateFin",
      "images": "$base64Image"
    }''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("ok");
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      print("echec");
    }
    print("print all element");
    print(widget.id);
    print(type.text);
    print(selectedDateFin);
  }

  chooseImage() {
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    var image = base64Decode("${data["images"]}");
    if (widget.id == null) {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.black,
            shadowColor: Colors.orange,
            iconTheme: IconThemeData(color: Colors.orange[700]),
            title: Center(
                child: new Text('Nouvel evenement',
                    style: TextStyle(color: Colors.orange[700], fontSize: 25))),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              // Column is a vertical, linear layout.
              child: Container(
                child: ListView(
                  children: [
                    Text("                    "),
                    FutureBuilder<File>(
                      future: file,
                      builder:
                          (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            null != snapshot.data) {
                          tmpFile = snapshot.data;
                          base64Image =
                              base64Encode(snapshot.data.readAsBytesSync());
                          return Flexible(
                            child: Image.file(
                              snapshot.data,
                              fit: BoxFit.fill,
                              height: 180,
                            ),
                          );
                        } else if (null != snapshot.error) {
                          return const Text(
                            "Erreur de Sélection d'Image",
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const Text(
                            "Aucune Image n'est Sélectioné",
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                    ),
                    Text("                    "),
                    OutlineButton(
                      onPressed: chooseImage,
                      child: Text('Choisir une Image'),
                    ),
                    Text("                    "),
                    Text("Nom de l'evenement",
                        style: TextStyle(color: Colors.orange[700])),
                    TextFormField(
                      controller: nom,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                          focusColor: Colors.orange,
                          border: OutlineInputBorder(),
                          labelText: ''),
                    ),
                    Text("                    "),
                    Text("Type d'evenement",
                        style: TextStyle(color: Colors.orange[700])),
                    TextFormField(
                      controller: type,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '',
                      ),
                    ),
                    Text("                    "),
                    Text("Date de debut",
                        style: TextStyle(color: Colors.orange[700])),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.event_note, color: Colors.orange),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        selectedDateDebut = value;
                        print(value);
                      },
                    ),
                    Text("                    "),
                    Text("Date de fin",
                        style: TextStyle(color: Colors.orange[700])),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.event_note, color: Colors.orange),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          selectedDateFin = value;
                        });
                        print(value);
                      },
                    ),
                    Text("                    "),
                    RaisedButton(
                      color: Colors.orange[600],
                      onPressed: () {
                        sendData();
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Text('Enregistrer'),
                    )
                  ],
                ),
              )));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.black,
            shadowColor: Colors.orange,
            iconTheme: IconThemeData(color: Colors.orange[700]),
            title: Center(
                child: new Text('Modifier evenement',
                    style: TextStyle(color: Colors.orange[700], fontSize: 25))),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              // Column is a vertical, linear layout.
              child: Container(
                child: ListView(
                  children: [
                    Text("                    "),
                    FutureBuilder<File>(
                      future: file,
                      builder:
                          (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            null != snapshot.data) {
                          tmpFile = snapshot.data;
                          base64Image =
                              base64Encode(snapshot.data.readAsBytesSync());
                          return Flexible(
                            child: Image.file(
                              snapshot.data,
                              fit: BoxFit.fill,
                              height: 180,
                            ),
                          );
                        } else if (null != snapshot.error) {
                          return const Text(
                            "Erreur de Sélection d'Image",
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Flexible(
                            child: Image.memory(
                              image,
                              height: 180,
                            ),
                          );
                        }
                      },
                    ),
                    Text("                    "),
                    OutlineButton(
                      onPressed: chooseImage,
                      child: Text('Choisir une Image'),
                    ),
                    Text("                    "),
                    Text("Nom de l'evenement",
                        style: TextStyle(color: Colors.orange[700])),
                    TextFormField(
                      controller: nom,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                          focusColor: Colors.orange,
                          border: OutlineInputBorder(),
                          labelText: ''),
                    ),
                    Text("                    "),
                    Text("Type d'evenement",
                        style: TextStyle(color: Colors.orange[700])),
                    TextFormField(
                      controller: type,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '',
                      ),
                    ),
                    Text("                    "),
                    Text("Date de debut",
                        style: TextStyle(color: Colors.orange[700])),
                    DateTimeFormField(
                      initialValue: DateTime.parse(data['dateDebut']),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.event_note, color: Colors.orange),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        selectedDateDebut = value;
                        print(value);
                      },
                    ),
                    Text("                    "),
                    Text("Date de fin",
                        style: TextStyle(color: Colors.orange[700])),
                    DateTimeFormField(
                      initialValue: DateTime.parse(data['dateFin']),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.event_note, color: Colors.orange),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          selectedDateFin = value;
                        });
                        print(value);
                      },
                    ),
                    Text("                    "),
                    RaisedButton(
                      color: Colors.orange[600],
                      onPressed: () {
                        sendData();
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Text('Enregistrer'),
                    )
                  ],
                ),
              )));
    }
  }
}
