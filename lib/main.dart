import 'package:flutter/material.dart';
import 'package:app_racha_conta/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app racha conta',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

