import 'package:flutter/material.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/widgets/alldoctors/category.dart';
import 'package:grad_project/widgets/alldoctors/screen_category.dart';
import 'package:grad_project/widgets/alldoctors/searchbar.dart';
import 'package:grad_project/widgets/doctor_card.dart';

class Alldoctors extends StatefulWidget {
  const Alldoctors({super.key});

  @override
  State<Alldoctors> createState() => _AlldoctorsState();
}

class _AlldoctorsState extends State<Alldoctors> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String? selectedCategory;
  List<Doctor> categoryDoctors = [];
  List<Doctor> filteredDoctors = [];
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
      name: "lollo",
      job: "Neurologist",
      hospital: "El-Demerdash Hospital",
      image: "assets/images/Pic.png",
      rate: 4.8,
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
      name: "Sara Mohamed",
      job: "Dermatologist",
      hospital: "Cleopatra Hospital",
      image: "assets/images/Pic3.png",
      rate: 4.8,
      beginDate: "11:00am",
      endDate: "6:00pm",
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
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;

      categoryDoctors = allDoctors.where((doctor) {
        final matchesCategory = doctor.job == category;
        return matchesCategory;
      }).toList();
    });
  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredDoctors = allDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase());
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
        title: Text("Doctors", style: TextStyle(fontWeight: FontWeight.bold)),
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

          AnimatedSwitcher(
            duration: Duration(microseconds: 300),
            child: isSearching
                ? SizedBox.shrink()
                : SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            filterByCategory("Neurologist");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScreenCategory(
                                    categoryDoctors: categoryDoctors,
                                  );
                                },
                              ),
                            );
                          },
                          child: alldoctorscategory(
                            name: "Neurologist",
                            image: "assets/images/alldoctors/Mask_group.png",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filterByCategory("Psychiatrist");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScreenCategory(
                                    categoryDoctors: categoryDoctors,
                                  );
                                },
                              ),
                            );
                          },
                          child: alldoctorscategory(
                            name: "Psychiatrist",
                            image: "assets/images/alldoctors/Mask_group2.png",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filterByCategory("Dermatologist");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScreenCategory(
                                    categoryDoctors: categoryDoctors,
                                  );
                                },
                              ),
                            );
                          },
                          child: alldoctorscategory(
                            name: "Dermatologist",
                            image: "assets/images/alldoctors/Mask_group3.png",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filterByCategory("Cardiologist");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScreenCategory(
                                    categoryDoctors: categoryDoctors,
                                  );
                                },
                              ),
                            );
                          },
                          child: alldoctorscategory(
                            name: "Cardiologist",
                            image: "assets/images/alldoctors/Mask_group4.png",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filterByCategory("Dentist");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScreenCategory(
                                    categoryDoctors: categoryDoctors,
                                  );
                                },
                              ),
                            );
                          },
                          child: alldoctorscategory(
                            name: "Dentist",
                            image: "assets/images/alldoctors/Mask_group5.png",
                          ),
                        ),
                      ],
                    ),
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
              );
            },
          ),
          if (isSearching && filteredDoctors.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(height: 100),
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
