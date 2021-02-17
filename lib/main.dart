import 'package:flutter/material.dart';
import 'package:jury_pro/splash.dart';
import 'newUpdate.dart';

void main() => runApp(new Splash());

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[200],
        accentColor: Colors.orange[200],
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.orange[700]),
        title: Center(
            child: Text('Connexion',
                style: TextStyle(fontSize: 25, color: Colors.orange[700]))),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Isaac'),
              accountEmail: new Text('isaac07.ik@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
                title: new Text('Inscription'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new NewUpdateEvent()));
                })
          ],
        ),
      ),
      body: Form(),
    );
  }
}

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        // Column is a vertical, linear layout.
        child: Container(
          child: ListView(
            children: <Widget>[
              Text("Entrez votre addresse mail",
                  style: TextStyle(color: Colors.orange)),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'isaac07.ik@gmail.com'),
              ),
              Text("                    "),
              Text("Entrez votre mot de passe",
                  style: TextStyle(color: Colors.orange)),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffix: IconButton(
                      icon: Icon(Icons.visibility), onPressed: () {}),
                ),
              ),
              Text("                    "),
              RaisedButton(
                color: Colors.orange[700],
                onPressed: () {
                  print('hello');
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                },
                child: Text('Submit'),
              )
            ],
          ),
        ));
  }
}
