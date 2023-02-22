import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project01/bottom_navigation.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
