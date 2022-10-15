import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/add_note_screen.dart';
import './model/user.dart';
import 'model/note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
      ),
      home: const HomeScreen(),
      routes: {
        AddNote.routeName: (context) => AddNote(),
      },
    );
  }
}
