import 'package:flutter/material.dart';
import './components/simple_map.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earthquake Mapping App',
      home: SimpleMap(title:"Earthquake Mapping App"),
    );
  }
}

