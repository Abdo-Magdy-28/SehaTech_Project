import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grad_project/widgets/doctor_card.dart';
import 'package:grad_project/widgets/mapdoctorcard.dart';
import 'package:latlong2/latlong.dart';

import 'package:grad_project/widgets/buildcard.dart';

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
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.dark, // Dark icons for light background
      ),
    );
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
  void dispose() {
    // Reset system UI when leaving the screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
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

                  // Blurred Header with SafeArea
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height:
                              MediaQuery.of(context).padding.top +
                              80, // Status bar + header height
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
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
                  ),

                  // Search Bar
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 90,
                    left: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
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
                  ),

                  // Floating Buttons
                  Positioned(
                    right: 16,
                    top: MediaQuery.of(context).padding.top + 170,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Color(0xff2260FF),
                      onPressed: () {},
                      shape: CircleBorder(), // Ensures circular shape
                      child: Icon(Icons.layers, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 370,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Color(0xff2260FF),
                      onPressed: getUserLocation,
                      shape: CircleBorder(), // Ensures circular shape
                      child: Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),

                  // ======= BLURRED BOTTOM SHEET =======
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
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
                              SizedBox(height: 20),

                              // TabBar as separate OutlinedButtons
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _buildTabButton(
                                          'Doctors',
                                          Icons.person,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: _buildTabButton(
                                          'Hospitals',
                                          Icons.local_hospital,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: _buildTabButton(
                                          'Pharmacy',
                                          Icons.medical_services,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              // List Header
                              Container(
                                width: 340,
                                height: 272,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Color(0xffDADADA)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Nearest ${selectedCategory}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'See all..',
                                              style: TextStyle(
                                                color: Color(0xff2260FF),
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 210,
                                      width: 350,
                                      child: Expanded(
                                        child: ListView(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          children:
                                              selectedCategory == 'Doctors'
                                              ? [
                                                  Mapdoctorcard(
                                                    devheight: devheight,
                                                    doctorimage: Image.asset(
                                                      'assets/images/Pic.png',
                                                    ),
                                                    job: "Neurologist",
                                                    hospital:
                                                        "El-Demerdash Hospital",
                                                    name: "Youssef Ali",
                                                    rate: 4.5,
                                                    begindate: "10:30am",
                                                    enddate: "5:30pm",
                                                  ),
                                                  Mapdoctorcard(
                                                    devheight: devheight,
                                                    doctorimage: Image.asset(
                                                      'assets/images/Pic.png',
                                                    ),
                                                    job: "Neurologist",
                                                    hospital:
                                                        "El-Demerdash Hospital",
                                                    name: "Youssef Ali",
                                                    rate: 4.5,
                                                    begindate: "10:30am",
                                                    enddate: "5:30pm",
                                                  ),
                                                  Mapdoctorcard(
                                                    devheight: devheight,
                                                    doctorimage: Image.asset(
                                                      'assets/images/Pic.png',
                                                    ),
                                                    job: "Neurologist",
                                                    hospital:
                                                        "El-Demerdash Hospital",
                                                    name: "Youssef Ali",
                                                    rate: 4.5,
                                                    begindate: "10:30am",
                                                    enddate: "5:30pm",
                                                  ),
                                                  Mapdoctorcard(
                                                    devheight: devheight,
                                                    doctorimage: Image.asset(
                                                      'assets/images/Pic.png',
                                                    ),
                                                    job: "Neurologist",
                                                    hospital:
                                                        "El-Demerdash Hospital",
                                                    name: "Youssef Ali",
                                                    rate: 4.5,
                                                    begindate: "10:30am",
                                                    enddate: "5:30pm",
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
                                    ),
                                  ],
                                ),
                              ),

                              // Dynamic List based on selected category
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ====== END OF BLURRED BOTTOM SHEET ====== //
                ],
              ),
      ),
    );
  }

  Widget _buildTabButton(String label, IconData icon) {
    bool isSelected = selectedCategory == label;
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          selectedCategory = label;
        });
      },
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Color(0xff2260FF),
        size: 16, // Smaller icon
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xff2260FF),
          fontFamily: 'Cairo',
          fontSize: 11, // Smaller text
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 29),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ), // Compact padding
        backgroundColor: isSelected ? Color(0xff2260FF) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: isSelected ? 4 : 0,
      ),
    );
  }
}
