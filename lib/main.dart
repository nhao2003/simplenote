import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/notes.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/add_note_screen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/setting_screen.dart';
import 'model/auth.dart';
import 'screens/setting_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Notes>(
          create: (_) => Notes('', [],[]),
          update: (ctx, auth, previousNotes) => Notes(
              auth.token.toString(),
              previousNotes?.NotesList == null ? [] : previousNotes!.NotesList,
              previousNotes?.DeletedNotesList == null ? [] : previousNotes!.DeletedNotesList,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (
          contex,
          auth,
          _,
        ) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black),
            ),
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                ),
                headline6: TextStyle(
                  color: Colors.black,
                )),
            primarySwatch: Colors.blue,
            fontFamily: "Poppins",
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          home: auth.isAuth ? HomeScreen() : LoginScreen(),
          routes: {
            AddNote.routeName: (context) => AddNote(),
            SettingScreen.routeName: (context) => SettingScreen(),
          },
        ),
      ),
    );
  }
}
