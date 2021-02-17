import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class NewUpdateEvent extends StatefulWidget {
  @override
  _NewUpdateEventState createState() => new _NewUpdateEventState();
}

class _NewUpdateEventState extends State<NewUpdateEvent> {
  String phpMsg;
  String regInfo;
  DateTime selectedDateDebut, selectedDateFin;

  //image variables

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  // chooseImage() {
  //   setState(() {
  //     file = ImagePicker.pickImage(source: ImageSource.gallery);
  //   });
  // }

  // DateTime dateDebut;
  // DateTime dateFin;

  TextEditingController nom = new TextEditingController();
  TextEditingController type = new TextEditingController();
  // TextEditingController dateDebut = new TextEditingController();
  // TextEditingController dateFin = new TextEditingController();

  sendData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://172.31.242.104:8080/evenements'));
    request.body = '''{
      "nom": "${nom.text}" ,
      "type": "${type.text}" ,
      "dateDebut": "$selectedDateDebut",
      "dateFin": "$selectedDateFin"
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
    print(nom.text);
    print(type.text);
    print(selectedDateFin);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
                    backgroundColor: Colors.black,
          shadowColor: Colors.orange,
          iconTheme: IconThemeData(color:Colors.orange[700]),
          title: Center(child: new Text('Nouvel evenement', style: TextStyle(color:Colors.orange[700], fontSize: 25))),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            // Column is a vertical, linear layout.
            child: Container(
              child: ListView(
                children: <Widget>[
                  Text("                    "),
                  Text("                    "),
                  Text("                    "),
                  Text("Nom de l'evenement",style: TextStyle(color:Colors.orange[700])),
                  TextFormField(

                    controller: nom,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                        focusColor: Colors.orange,
                        border: OutlineInputBorder(), labelText: ''),
                  ),
                  Text("                    "),
                  Text("Type d'evenement",style: TextStyle(color:Colors.orange[700])),
                  TextFormField(
                    controller: type,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '',
                    ),
                  ),
                  Text("                    "),
                  Text("Date de debut",style: TextStyle(color:Colors.orange[700])),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note, color:Colors.orange),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      selectedDateDebut = value;
                      print(value);
                    },
                  ),
                  Text("                    "),
                  Text("Date de fin" , style: TextStyle(color:Colors.orange[700])),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note, color: Colors.orange),
                      
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
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
                      Navigator.of(
                                  context)
                              .pop();
                          setState(() {});
                    },
                    child: Text('Enregistrer'),
                  )
                ],
              ),
            )));
  }
}
