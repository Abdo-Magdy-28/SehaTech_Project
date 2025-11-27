import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grad_project/widgets/doctor_card.dart';
import 'package:grad_project/widgets/mapdoctorcard.dart';
import 'package:grad_project/widgets/mapdoctorcarddetail.dart';
import 'package:grad_project/widgets/maphospitalcard.dart';
import 'package:grad_project/widgets/mappharmacycard.dart';
import 'package:grad_project/widgets/mapscreen/blurred_appbar.dart';
import 'package:grad_project/widgets/mapscreen/circlemap.dart';
import 'package:grad_project/widgets/mapscreen/searchbar.dart';
import 'package:latlong2/latlong.dart';

import 'package:grad_project/widgets/buildcard.dart';

class Mapscreen extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Mapscreen> {
  LatLng? currentLocation;
  String selectedCategory = 'Hospitals';
  Map<String, dynamic>? selectedDoctor;

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
                  // Mapscreen - Full Screen
                  circlemap(currentLocation: currentLocation),

                  // Blurred Header with SafeArea
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: blurred_appbar(),
                  ),

                  // Search Bar
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 90,
                    left: 16,
                    right: 16,
                    child: searchbar(),
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
                                child: selectedDoctor != null
                                    ? _buildDoctorDetailCard()
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Nearest $selectedCategory',
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 210,
                                            width: 350,
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
                                                        onviewpressed: () {
                                                          setState(() {
                                                            selectedDoctor = {
                                                              'name':
                                                                  'Youssef Ali',
                                                              'job':
                                                                  'Neurologist',
                                                              'hospital':
                                                                  'El-Demerdash Hospital',
                                                              'rate': 4.8,
                                                              'experience':
                                                                  '3yr',
                                                              'treated': '50+',
                                                              'hourlyRate':
                                                                  '350 L.E',
                                                              'begindate':
                                                                  '10:30am',
                                                              'enddate':
                                                                  '5:30pm',
                                                            };
                                                          });
                                                        },
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
                                                        onviewpressed: () {
                                                          setState(() {
                                                            selectedDoctor = {
                                                              'name':
                                                                  'Youssef Ali',
                                                              'job':
                                                                  'Neurologist',
                                                              'hospital':
                                                                  'El-Demerdash Hospital',
                                                              'rate': 4.8,
                                                              'experience':
                                                                  '3yr',
                                                              'treated': '50+',
                                                              'hourlyRate':
                                                                  '350 L.E',
                                                              'begindate':
                                                                  '10:30am',
                                                              'enddate':
                                                                  '5:30pm',
                                                            };
                                                          });
                                                        },
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
                                                        onviewpressed: () {
                                                          setState(() {
                                                            selectedDoctor = {
                                                              'name':
                                                                  'Youssef Ali',
                                                              'job':
                                                                  'Neurologist',
                                                              'hospital':
                                                                  'El-Demerdash Hospital',
                                                              'rate': 4.8,
                                                              'experience':
                                                                  '3yr',
                                                              'treated': '50+',
                                                              'hourlyRate':
                                                                  '350 L.E',
                                                              'begindate':
                                                                  '10:30am',
                                                              'enddate':
                                                                  '5:30pm',
                                                            };
                                                          });
                                                        },
                                                      ),
                                                    ]
                                                  : selectedCategory ==
                                                        'Hospitals'
                                                  ? [
                                                      Maphospitalcard(
                                                        name: 'El-Amawy',
                                                        rate: 4.8,
                                                        devheight: devheight,
                                                      ),
                                                      Maphospitalcard(
                                                        name: 'El-Amawy',
                                                        rate: 4.8,
                                                        devheight: devheight,
                                                      ),
                                                      Maphospitalcard(
                                                        name: 'El-Amawy',
                                                        rate: 4.8,
                                                        devheight: devheight,
                                                      ),
                                                    ]
                                                  : [
                                                      Mappharmacycard(
                                                        name:
                                                            'El-Amiry Hospital',
                                                        devheight: devheight,
                                                        rate: 4.8,
                                                      ),
                                                      Mappharmacycard(
                                                        name:
                                                            'El-Amiry Hospital',
                                                        devheight: devheight,
                                                        rate: 4.8,
                                                      ),
                                                      Mappharmacycard(
                                                        name:
                                                            'El-Amiry Hospital',
                                                        devheight: devheight,
                                                        rate: 4.8,
                                                      ),
                                                    ],
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

  Widget _buildDoctorDetailCard() {
    if (selectedDoctor == null) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedDoctor = null;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'Dr : ${selectedDoctor!['name']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.navigation, color: Color(0xff2260FF)),
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/Pic.png'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr : ${selectedDoctor!['name']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      '${selectedDoctor!['job']} | ${selectedDoctor!['hospital']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                '${selectedDoctor!['rate']}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.star, color: Colors.amber, size: 18),

              Icon(Icons.access_time, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '${selectedDoctor!['begindate']} - ${selectedDoctor!['enddate']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn('Experience', selectedDoctor!['experience']),
              _buildStatColumn('Treated', selectedDoctor!['treated']),
              _buildStatColumn('Hourly Rate', selectedDoctor!['hourlyRate']),
            ],
          ),

          // Book Button
          ElevatedButton(
            onPressed: () {
              // Book appointment logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff2260FF),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
