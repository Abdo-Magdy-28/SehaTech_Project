import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grad_project/widgets/buildcard.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  LatLng? currentLocation;
  String selectedCategory = 'Hospitals';

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return;
    }

    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Map - Full Screen
                FlutterMap(
                  options: MapOptions(
                    initialCenter: currentLocation!,
                    initialZoom: 15.0,
                  ),
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
                          child: Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 35,
                          ),
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
                ),

                // Header
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ), // البلور أقوى
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.2,
                            ), // أبيض شفاف للGlassmorphism
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // حواف مدورة
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                0.3,
                              ), // حدود خفيفة للزجاج
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Expanded(
                                child: Text(
                                  'Explore Nearby',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Search Bar
                Positioned(
                  top: 100,
                  left: 16,
                  right: 16,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Floating Buttons
                Positioned(
                  right: 16,
                  top: 180,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.blue,
                    onPressed: () {},
                    child: Icon(Icons.layers, color: Colors.white),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 370,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.blue,
                    onPressed: getUserLocation,
                    child: Icon(Icons.my_location, color: Colors.white),
                  ),
                ),

                // Bottom Sheet
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        // Drag Handle
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: 15),

                        // TabBar
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              _buildTab('Doctors', Icons.person),
                              _buildTab('Hospitals', Icons.local_hospital),
                              _buildTab('Pharmacy', Icons.medical_services),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // List Header
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nearest ${selectedCategory}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('See all'),
                              ),
                            ],
                          ),
                        ),

                        // Dynamic List based on selected category
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: selectedCategory == 'Doctors'
                                ? [
                                    buildCard(
                                      name: 'Dr : Youssef Ali',
                                      type:
                                          'Neurologist | El-Demerdash Hospital',
                                      rating: '4.8',
                                      hours: '10:30am - 5:30pm',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'Dr : Youssef Ali',
                                      type:
                                          'Neurologist | El-Demerdash Hospital',
                                      rating: '4.8',
                                      hours: '10:30am - 5:30pm',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'Dr : Youssef Ali',
                                      type:
                                          'Neurologist | El-Demerdash Hospital',
                                      rating: '4.8',
                                      hours: '10:30am - 5:30pm',
                                    ),
                                  ]
                                : selectedCategory == 'Pharmacy'
                                ? [
                                    buildCard(
                                      name: 'El-Amawy',
                                      type: 'Pharmacy',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'El-Amawy',
                                      type: 'Pharmacy',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'El-Amawy',
                                      type: 'Pharmacy',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                  ]
                                : [
                                    buildCard(
                                      name: 'El-Amiry Hospital',
                                      type: 'Government Hospital',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'El-Amiry Hospital',
                                      type: 'Government Hospital',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                    SizedBox(height: 10),
                                    buildCard(
                                      name: 'El-Amiry Hospital',
                                      type: 'Government Hospital',
                                      rating: '4.8',
                                      hours: '24-Hours',
                                    ),
                                  ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(String label, IconData icon) {
    bool isSelected = selectedCategory == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
