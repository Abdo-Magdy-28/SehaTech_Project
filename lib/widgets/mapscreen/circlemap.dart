import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class circlemap extends StatelessWidget {
  const circlemap({super.key, required this.currentLocation});

  final LatLng? currentLocation;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: currentLocation!, initialZoom: 15.0),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=mIKqtgOr2ggQ9XftPFEl',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 40,
              height: 40,
              point: currentLocation!,
              child: Icon(Icons.my_location, color: Colors.blue, size: 35),
            ),
          ],
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: currentLocation!,
              color: Colors.blue.withOpacity(0.2),
              borderStrokeWidth: 2,
              borderColor: Colors.blue,
              radius: 100,
            ),
          ],
        ),
      ],
    );
  }
}
