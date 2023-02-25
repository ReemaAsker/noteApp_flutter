import 'package:flutter/material.dart';
import 'package:noteapp/MainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/edit.dart';
import 'package:noteapp/screens/add_note.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromARGB(255, 249, 252, 255),
      theme: ThemeData(fontFamily: 'OpenSans'),
      routes: {
        "/AddNote": (context) => NoteScreen(),
        "/showNote": (context) => Edit(),
      },
      home: Container(
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/note.png'),
            ),
            SizedBox(height: 200),
            ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    ),
                child: Text('Get Started'))
          ],
        ),
      ),
    );
  }
}
