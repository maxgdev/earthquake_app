import 'package:flutter/material.dart';
// import './components/maps_page.dart';
import './components/simple_map.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earthquake Mapping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Earthquake Mapping App '),
      home: SimpleMap(title:"Earthquake Mapping App"),
    );
  }
}

