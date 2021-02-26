import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jury_pro/evenement.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

import '_main.dart';

class Candidat extends StatefulWidget {
  @override
  _CandidatState createState() => new _CandidatState();

  var id;
  Candidat({this.id});
}

class _CandidatState extends State<Candidat> {
  String phpMsg;
  String regInfo;
  DateTime selectedDateDebut, selectedDateFin;
  var data;
  var event;
  List evenements;
  var eventId;

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
        await http.get("http://172.31.240.26:8080/candidats/" + _uri);
    data = json.decode(response.body);

    setState(() {
      data = data;
    });
    if (widget.id != null) {
      nom.text = data['nom'];
      type.text = data['type'];
    }
  }
 

  Future getEvent(var uri) async {
    String _uri = uri.toString();
    http.Response response =
        await http.get("http://172.31.240.26:8080/evenements/" + _uri);
    event = json.decode(response.body);

    setState(() {
      event = event;
    });
  }

  @override
  void initState() {
    super.initState();
    getEvent("169");
    getData(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    Uint8List image;
    if (data["candidat_photo"] != null) {
      image = base64Decode(data["candidat_photo"]);}
    {
      return new Scaffold(
        
        appBar: new AppBar(
          backgroundColor: Colors.black,
          shadowColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.orange[700]),
          title: Center(
              child: new Text("Candidat N° ${data['candidat_code']}",
                  style: TextStyle(color: Colors.orange[700], fontSize: 25))),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      child: data["candidat_photo"] != null? Image.memory(image,height: 180,): Text(''),
                    ),
                    Positioned(
                      right: -27,
                      bottom: 0,
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          color: Color(0xFFF5F6F9),
                          onPressed: () {},
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Nom : ${data['candidat_nom']} ${data['candidat_prenom']}",
                icon: "assets/icons/User Icon.svg",
                press: () => {},
              ),
              ProfileMenu(
                text: "Prenoms : ${data['candidat_prenom']}",
                icon: "assets/icons/Bell.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Telephone : ${data['candidat_telephone']}",
                icon: "assets/icons/Phone.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Email : ${data['candidat_telephone']}",
                icon: "assets/icons/Mail.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Participent à : ${event[nom]}",
                icon: "assets/icons/Log out.svg",
                press: () {},
              ),
            ],
          ),
        ),
      );
    }
  }
}
