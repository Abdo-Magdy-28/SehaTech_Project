import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  @override
  _ExploreNearbyScreenState createState() => _ExploreNearbyScreenState();
}

class _ExploreNearbyScreenState extends State<Map> {
  String selectedCategory = 'Doctors';

  // بدلنا GoogleMapController → MapController
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
