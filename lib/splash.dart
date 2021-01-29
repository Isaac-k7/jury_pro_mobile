import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'main.dart';

void main() {
  runApp(Splash());
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Normal Logo Splash screen
    Widget example1 = SplashScreenView(
      home: Home(),
      duration: 3000,
      imageSize: 200,
      imageSrc: "images/orange.png",
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Splash screen Demo',
      home: example1,
    );
  }
}
