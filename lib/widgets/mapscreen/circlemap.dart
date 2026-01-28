import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CircleMap extends StatelessWidget {
  const CircleMap({super.key, required this.currentLocation});

  final LatLng currentLocation; // ✅ Google Maps LatLng

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: currentLocation, zoom: 15),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,

      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      },

      circles: {
        Circle(
          circleId: const CircleId('radius_circle'),
          center: currentLocation,
          radius: 100, // meters
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      },
    );
  }
}
