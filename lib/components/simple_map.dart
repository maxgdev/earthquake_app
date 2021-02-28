import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  final String title;
  SimpleMap({this.title});

  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  GoogleMapController mapController;
  static LatLng _fav1 = const LatLng(51.501476, -0.140634); // Buckingham Palace, London, UK
  static LatLng _fav2 = const LatLng(52.827015, 0.515626); // Sandringham
  static LatLng _fav3 = const LatLng(52.073833038,-1.01683); // Sandringham

  void _onMapCreated(GoogleMapController controller) {
     mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _fav1,
          zoom: 11.0
          ),
        
        )
    );
  }
}
