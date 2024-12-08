import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(AUPPistApp());
}

class AUPPistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AUPPist',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.amber,
        fontFamily: 'Parkinsans',
      ),
      home: WelcomePage(),
    );
  }
}
