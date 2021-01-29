import 'package:flutter/material.dart';
import 'package:jury_pro/Candidat.dart';
import 'package:jury_pro/newUpdate.dart';
import 'Evenement.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String title = "Evenements";
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[200],
        accentColor: Colors.orange[200],
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("new pressed");
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => edit));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[700],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.grey[900],
        body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60)),
                    color: Colors.black,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.orange[700], fontSize: 48),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                      alignment: Alignment.topCenter,
                      color: Colors.black,
                      child: DefaultTabController(
                        length: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30)),
                                  color: Colors.white,
                                ),
                                height: double.infinity,
                                child: TabBarView(
                                  children: [
                                    evenement,
                                    candidat,
                                    Text("data3"),
                                    Text("data4"),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.black,
                                height: double.infinity,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Scaffold(
                                    appBar: AppBar(
                                        backgroundColor: Colors.black,
                                        bottom: PreferredSize(
                                          preferredSize: Size(300, 200),
                                          child: Container(
                                            child: TabBar(tabs: [
                                              Tab(
                                                  child: Text("Evenement",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[700],
                                                          fontSize: 20))),
                                              Tab(
                                                  child: Text("Candidat",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[700],
                                                          fontSize: 20))),
                                              Tab(
                                                  child: Text("Groupe",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[700],
                                                          fontSize: 20))),
                                              Tab(
                                                  child: Text("Critère",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[700],
                                                          fontSize: 20))),
                                            ]),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

var evenement = new Evenement();
var candidat = new Candidat();
var edit = new NewUpdateEvent();
