import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lojavirtual/view/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter's Clothing",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 4, 125, 141),
      ),

      home: home_screen(),
    );
  }
}