import 'package:earthquake_app/components/earth_quake.dart';
import 'package:flutter/material.dart';
// import './components/simple_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earthquake Mapping App',
      // home: SimpleMap(title:"Earthquake Mapping App"),
      home: EarthQuakeApp(),
      // home: QuakesApp(),
    );
  }
}

