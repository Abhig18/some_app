import 'package:flutter/material.dart';
import 'package:some_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Testing",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
