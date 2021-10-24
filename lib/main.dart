import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const WoltApp());
}

class WoltApp extends StatelessWidget {
  const WoltApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Delivery Fee Calculator'),
    );
  }
}

