import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'evenement.dart';
import 'main.dart';
import '_main.dart';

class Home extends StatefulWidget {
  static const pageName = "Evenement";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Profil",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.verified,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Profil",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.event_note,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Evenements",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.verified,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Groupe",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Candidats",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
                Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Icon(
                          Icons.verified,
                          size: 100,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text("Profil",
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[700]))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void editEvenement() {}
