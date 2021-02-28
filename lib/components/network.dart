import 'dart:convert';
import 'package:http/http.dart';
import './earthquake_model.dart';

class Network {

  Future<EarthQuake> getAllQuakes() async {
     var apiUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";

     final response = await get(Uri.encodeFull(apiUrl));
            
     if (response.statusCode == 200) {
        print("EarthQuake data: ${response.body}");
        return EarthQuake.fromJson(json.decode(response.body));
     }else {
        throw Exception("Error getting quakes");
     }

  }
}