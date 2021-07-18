import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_notes/pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.redAccent,
        accentColor: Colors.redAccent,
        scaffoldBackgroundColor: Color(0xff070706)
      ),
      home: LoginPage(),
    );
  }
}
