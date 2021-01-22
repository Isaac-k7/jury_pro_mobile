import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List evenements;

  Future getData() async {
    http.Response response =
        await http.get("http://172.31.240.248:8080/evenements");
    data = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jury Pro"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text("${data[index]["evenement_nom"]}"),
                  subtitle: Text(
                    "Evenement de ${data[index]["evenement_type"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.network("https://picsum.photos/250?image=9",
                    fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${data[index]["evenement_description"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(alignment: MainAxisAlignment.end, children: [
                  FlatButton(
                    textColor: Colors.black,
                    color: Colors.deepOrange,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Lire Plus'),
                  ),
                  FlatButton(
                    textColor: Colors.deepOrange,
                    color: Colors.black,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Participer'),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
