import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CircleMap extends StatefulWidget {
  const CircleMap({
    super.key,
    required this.currentLocation,
    this.extraMarker,
    this.extraMarkerLabel,
    this.markers = const {},
    this.onMapCreated,
    this.radius = 100,
  });

  final LatLng currentLocation;
  final LatLng? extraMarker;
  final String? extraMarkerLabel;
  final Set<Marker> markers;
  final void Function(GoogleMapController controller)? onMapCreated;
  final double radius; // meters

  @override
  State<CircleMap> createState() => _CircleMapState();
}

class _CircleMapState extends State<CircleMap> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(covariant CircleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocation != widget.currentLocation) {
      _controller?.animateCamera(
        CameraUpdate.newLatLng(widget.currentLocation),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final allMarkers = <Marker>{
      ...widget.markers,
      Marker(
        markerId: const MarkerId('current_location'),
        position: widget.currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      if (widget.extraMarker != null)
        Marker(
          markerId: const MarkerId('pharmacy_target'),
          position: widget.extraMarker!,
          infoWindow: InfoWindow(title: widget.extraMarkerLabel ?? ''),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
    };

    return GoogleMap(
      onMapCreated: (controller) {
        _controller = controller;
        widget.onMapCreated?.call(controller);
      },
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation,
        zoom: 15,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: allMarkers,
      circles: {
        Circle(
          circleId: const CircleId('radius_circle'),
          center: widget.currentLocation,
          radius: widget.radius,
          fillColor: Colors.blue.withOpacity(0.15),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      },
    );
  }
}
