// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/pages/home.dart';
import 'package:flutter_application_2/pages/profile.dart';
import 'package:flutter_application_2/pages/settings.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int idx = 0;

  //
  void _navigationBottomBar(int index) {
    setState(() {
      idx = index;
    });
  }

  //
  List _pages = [Home(), Profile(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: _pages[idx],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: idx,
          onTap: _navigationBottomBar,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_rounded), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ]),
    );
  }
}
