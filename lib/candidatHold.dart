import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Candidat extends StatefulWidget {
  static const pageName = "ContactList";
  @override
  _CandidatListState createState() => _CandidatListState();
}

class _CandidatListState extends State<Candidat> {
  Map<int, bool> countToValue = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (int count in List.generate(9, (index) => index + 1))
            Card(
              child: ListTile(
                onTap: () {
                  print("hello");
                },
                title: Text('List item $count'),
                subtitle: Text('Secondary text'),
                leading: FlutterLogo(size: 50.0),
                selected: countToValue[count] ?? false,
                trailing: Checkbox(
                  value: countToValue[count] ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      countToValue[count] = value;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
