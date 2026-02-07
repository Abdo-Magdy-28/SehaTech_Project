import 'package:flutter/material.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/screens/doctor_details.dart';
import 'package:grad_project/widgets/alldoctors/category.dart';
import 'package:grad_project/widgets/alldoctors/screen_category.dart';
import 'package:grad_project/widgets/doctor_card.dart';
import 'package:grad_project/widgets/maphospitalcard.dart';
import 'package:grad_project/widgets/mappharmacycard.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  @override
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String? selectedCategory;
  List<Doctor> filteredDoctors = [];
  List<Hospital> filteredhospitals = [];
  List<Pharmacy> filteredpharmacies = [];
  List<Pharmacy> pharmacies = [
    Pharmacy(
      name: 'El-Amawy',
      category: 'Pharmacy',
      rating: 4.8,
      is24Hours: true,
    ),
    Pharmacy(
      name: 'Seif Pharmacy',
      category: 'Pharmacy',
      rating: 4.6,
      is24Hours: true,
    ),
    Pharmacy(
      name: 'El-Ezaby Pharmacy',
      category: 'Pharmacy',
      rating: 4.7,
      is24Hours: false,
    ),
  ];
  List<Hospital> hospitals = [
    Hospital(
      name: 'El-Amiry Hospital',
      category: 'Government Hospital',
      rating: 4.8,
      openTime: '10:30am',
      closeTime: '5:30pm',
    ),
    Hospital(
      name: 'Cairo Medical Center',
      category: 'Private Hospital',
      rating: 4.5,
      openTime: '8:00am',
      closeTime: '10:00pm',
    ),
    Hospital(
      name: 'Al-Salam Hospital',
      category: 'Government Hospital',
      rating: 4.2,
      openTime: '9:00am',
      closeTime: '6:00pm',
    ),
  ];
  List<Doctor> allDoctors = [
    Doctor(
      name: "Youssef Ali",
      job: "Neurologist",
      hospital: "El-Demerdash Hospital",
      image: "assets/images/Pic.png",
      rate: 4.5,
      beginDate: "10:30am",
      endDate: "5:30pm",
    ),

    Doctor(
      name: "Ahmed Hassan",
      job: "Cardiologist",
      hospital: "Ain Shams Hospital",
      image: "assets/images/Pic2.png",
      rate: 4.2,
      beginDate: "9:00am",
      endDate: "4:00pm",
    ),

    Doctor(
      name: "Omar Khaled",
      job: "Dentist",
      hospital: "Smile Care Clinic",
      image: "assets/images/Pic4.png",
      rate: 4.1,
      beginDate: "8:30am",
      endDate: "2:30pm",
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = allDoctors;
    filteredhospitals = hospitals;
    filteredpharmacies = pharmacies;
  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredDoctors = allDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredhospitals = hospitals.where((hospital) {
        return hospital.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredpharmacies = pharmacies.where((pharmacy) {
        return pharmacy.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Find What You need",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: search,
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff0D5FA7)),
                  ),
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Alldoctors()),
                    );
                  },
                  child: alldoctorscategory(
                    name: "Doctors",
                    image: "assets/images/search/Maskgroup.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: alldoctorscategory(
                    name: "Pharmacies",
                    image: "assets/images/search/Maskgroup2.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: alldoctorscategory(
                    name: "Hospitals",
                    image: "assets/images/search/Maskgroup4.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: alldoctorscategory(
                    name: "Medicines",
                    image: "assets/images/search/Maskgroup3.png",
                  ),
                ),
              ],
            ),
          ),
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Popular Doctors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              final doctor = filteredDoctors[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetails(
                          name: doctor.name,
                          begindate: doctor.beginDate,
                          enddate: doctor.endDate,
                          hospital: doctor.hospital,
                          job: doctor.job,
                          rate: doctor.rate,
                        ),
                      ),
                    );
                  },
                  child: Doctorcard(
                    devheight: devheight,
                    doctorimage: Image.asset('assets/images/Pic.png'),
                    job: doctor.job,
                    hospital: doctor.hospital,
                    name: doctor.name,
                    rate: doctor.rate,
                    begindate: doctor.beginDate,
                    enddate: doctor.endDate,
                  ),
                ),
              );
            },
          ),
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Popular Hospitals",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredhospitals.length,
            itemBuilder: (context, index) {
              final hospital = filteredhospitals[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Maphospitalcard(
                    devheight: devheight,
                    rate: hospital.rating,
                    name: hospital.name,
                  ),
                ),
              );
            },
          ),

          if (!isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Popular Pharmacies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredpharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = filteredpharmacies[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Mappharmacycard(
                    devheight: devheight,
                    rate: pharmacy.rating,
                    name: pharmacy.name,
                  ),
                ),
              );
            },
          ),

          if (isSearching &&
              filteredDoctors.isEmpty &&
              filteredhospitals.isEmpty &&
              filteredpharmacies.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset('assets/images/alldoctors/search.png'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Sorry, no results found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Please try a different search term.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Most Searched Medicines",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 36 - 10) / 2,
                  child: medicinecard(
                    name: "Liveasy Wellness",
                    image:
                        "assets/images/search/liveasy-wellness-calcium-magnesium-vitamin-d3-zinc-bones-dental-health-bottle-60-tabs-6.1-1733485732.png",
                    rate: 4.8,
                    description: "Calcium Magnesium Vitamin",
                    componant: "D3 & Zine",
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 36 - 10) / 2,
                  child: medicinecard(
                    name: "Dr.Morepen",
                    image:
                        "assets/images/search/liveasy-wellness-calcium-magnesium-vitamin-d3-zinc-bones-dental-health-bottle-60-tabs-6.1-1733485732q3.png",
                    rate: 4.8,
                    description: "Calcium Magnesium Vitamin",
                    componant: "D3 & Zine",
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 36 - 10) / 2,
                  child: medicinecard(
                    name: "Pharmeasy Optima",
                    image: "assets/images/search/lol.png",
                    rate: 3.8,
                    description: "Calcium Magnesium Vitamin",
                    componant: "D3 & Zine",
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 36 - 10) / 2,
                  child: medicinecard(
                    name: "Juman Juice",
                    image: "assets/images/search/21.png",
                    rate: 4.8,
                    description: "Calcium Magnesium Vitamin",
                    componant: "D3 & Zine",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class medicinecard extends StatelessWidget {
  medicinecard({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.componant,
    required this.rate,
  });

  String name, image, description, componant;
  double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 270,
      width: 160,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(height: 140, width: 140, child: Image.asset(image)),
          ),
          // Name with ellipsis
          Positioned(
            top: 160,
            left: 10,
            child: SizedBox(
              width: 100, // Leave space for rating on the right
              child: Text(
                name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 160,
            child: Row(
              children: [
                Text(
                  "$rate",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 2),
                SizedBox(
                  height: 15,
                  width: 15,
                  child: Image.asset("assets/images/Star.png"),
                ),
              ],
            ),
          ),
          // Description with ellipsis
          Positioned(
            left: 10,
            top: 185,
            child: SizedBox(
              width: 140, // Card width (160) - padding (10+10)
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          // Component with ellipsis
          Positioned(
            left: 10,
            top: 205,
            child: SizedBox(
              width: 140,
              child: Text(
                componant,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.5),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff0D61EC),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 160,
              height: 35,
              child: Center(
                child: Text("View", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
