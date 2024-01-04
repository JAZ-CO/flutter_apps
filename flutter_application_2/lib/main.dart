import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/pages/first.dart';
import 'package:flutter_application_2/pages/home.dart';
import 'package:flutter_application_2/pages/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/first': (context) => FirstPage(),
        '/homepage': (context) => Home(),
        '/settingsPage': (context) => Settings()
      },
    );
  }
}
