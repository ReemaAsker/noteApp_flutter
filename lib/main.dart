import 'package:flutter/material.dart';
import 'package:noteapp/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget nav() {
    Color mycolor = Color.fromARGB(255, 19, 33, 240);
    return SplashScreen(
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY Notes',
      home: nav(),
    );
  }
}
