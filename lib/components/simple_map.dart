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
  static LatLng _fav1 =
      const LatLng(51.501476, -0.140634); // Buckingham Palace, London, UK
  static LatLng _fav2 = const LatLng(52.827015, 0.515626); // Sandringham
  static LatLng _fav3 = const LatLng(52.073833038, -1.01683); // Silverstone
  static LatLng _fav4 = const LatLng(51.4932646936, -0.1214661808); // House of Parliament

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
          markers: {buckinghamPalace, parliamentMarker},
          mapType: MapType.terrain,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _fav1, zoom: 5.0),
        ));
  }

  Marker buckinghamPalace = Marker(
      markerId: MarkerId("Buckingham Palace"),
      position: _fav1,
      infoWindow: InfoWindow(
          title: "Buckingham Palace", snippet: "Buckingham Palace, London, UK"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  Marker silverstoneMarker = Marker(
      markerId: MarkerId("Silverstone"),
      position: _fav3,
      infoWindow: InfoWindow(
          title: "Silverstone", snippet: "Silverstone Racing Circuit"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  Marker parliamentMarker = Marker(
      markerId: MarkerId("House of Parliament"),
      position: _fav4,
      infoWindow: InfoWindow(
          title: "House of Parliament", snippet: "House of Parliament"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));    

}
