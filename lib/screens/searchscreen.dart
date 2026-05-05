import 'package:flutter/material.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/screens/Hospitals/allhospitals.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/screens/medicines/allmedicines.dart';
import 'package:grad_project/screens/pharmacies/allpahramcies.dart';
import 'package:grad_project/screens/pharmacies/pharmacydetails.dart';
import 'package:grad_project/widgets/doctors/doctor_details.dart';
import 'package:grad_project/widgets/doctors/category.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:grad_project/widgets/hosptials/hospital_card.dart';
import 'package:grad_project/widgets/mainscaffold.dart';
import 'package:grad_project/widgets/maphospitalcard.dart';
import 'package:grad_project/widgets/mappharmacycard.dart';
import 'package:grad_project/widgets/Medicines/medicinecard.dart';
import 'package:grad_project/widgets/pharmacies/pharmacy_card.dart';

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
    Pharmacy(name: 'El-Amawy', rating: 4.8, is24Hours: true),
    Pharmacy(name: 'Seif Pharmacy', rating: 4.6, is24Hours: true),
    Pharmacy(name: 'El-Ezaby Pharmacy', rating: 4.7, is24Hours: false),
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
                      MaterialPageRoute(
                        builder: (context) =>
                            MainScaffold(currentIndex: 3, child: Alldoctors()),
                      ),
                    );
                  },
                  child: alldoctorscategory(
                    name: "Doctors",
                    image: "assets/images/search/Maskgroup.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScaffold(
                          currentIndex: 3,
                          child: Allpahramcies(),
                        ),
                      ),
                    );
                  },
                  child: alldoctorscategory(
                    name: "Pharmacies",
                    image: "assets/images/search/Maskgroup2.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScaffold(
                          currentIndex: 3,
                          child: Allhospitals(),
                        ),
                      ),
                    );
                  },
                  child: alldoctorscategory(
                    name: "Hospitals",
                    image: "assets/images/search/Maskgroup4.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScaffold(
                          currentIndex: 3,
                          child: Allmedicines(),
                        ),
                      ),
                    );
                  },
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Hospitaldetails(
                          name: hospital.name,
                          rate: hospital.rating,
                          opentime: hospital.openTime,
                          closetime: hospital.closeTime,
                          devheight: devheight,
                          category: hospital.category,
                        ),
                      ),
                    );
                  },
                  child: HospitalCard(
                    rate: hospital.rating,
                    name: hospital.name,
                    category: hospital.category,
                    opendate: hospital.openTime,
                    closedate: hospital.closeTime,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PharmacyDetails(
                          name: pharmacy.name,
                          rate: pharmacy.rating,
                          isopen24: pharmacy.is24Hours,
                          devheight: devheight,
                        ),
                      ),
                    );
                  },
                  child: PharmacyCard(
                    rate: pharmacy.rating,
                    name: pharmacy.name,
                    isopen24: true,
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
                  child: MedicineCard(
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
                  child: MedicineCard(
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
                  child: MedicineCard(
                    name: "Pharmeasy Optima",
                    image: "assets/images/search/lol.png",
                    rate: 3.8,
                    description: "Calcium Magnesium Vitamin",
                    componant: "D3 & Zine",
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 36 - 10) / 2,
                  child: MedicineCard(
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
