import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './earthquake_model.dart';
import './network.dart';

class EarthQuakeApp extends StatefulWidget {
  @override
  _EarthQuakeAppState createState() => _EarthQuakeAppState();
}

class _EarthQuakeAppState extends State<EarthQuakeApp> {
  Future<EarthQuake> _earthQuakeData;
  // Completer?? Why different from earlier methods?
  // What problem is it solving??
  //
  Completer<GoogleMapController> _controller = Completer();
  // Set List of markers to empty, zero
  List<Marker> _markerList = <Marker>[];
  double _zoomVal = 5.0; // Initial zoom value
   
  // set initState
  @override
  void initState() {
    super.initState();
    // get earthquake from json API
    _earthQuakeData = Network().getAllQuakes();

    _earthQuakeData.then((value) =>
        {print("Place: ${value.features[0].properties.place}")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _displayGoogleMap(context),
        ],
      ),
    );
  }
}
  Widget _displayGoogleMap( context) {
    return Container(
      child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: null,
          initialCameraPosition: CameraPosition(target: LatLng(51.4932646936, -0.1214661808), zoom: 5.0),
        )
    );
  }
