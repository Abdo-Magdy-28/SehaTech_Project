import 'package:flutter/material.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/widgets/alldoctors/category.dart';
import 'package:grad_project/widgets/alldoctors/searchbar.dart';
import 'package:grad_project/widgets/doctor_card.dart';

class Alldoctors extends StatefulWidget {
  const Alldoctors({super.key});

  @override
  State<Alldoctors> createState() => _AlldoctorsState();
}

class _AlldoctorsState extends State<Alldoctors> {
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

  void search(String query) {
    setState(() {
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
        centerTitle: true,
        title: Text("Doctors"),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey, // line color
          ),
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
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: search,
                decoration: InputDecoration(
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
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                alldoctorscategory(
                  name: "Neurologist",
                  image: "assets/images/alldoctors/Mask_group.png",
                ),
                alldoctorscategory(
                  name: "Psychiatrist",
                  image: "assets/images/alldoctors/Mask_group2.png",
                ),
                alldoctorscategory(
                  name: "Dermatologist",
                  image: "assets/images/alldoctors/Mask_group3.png",
                ),
                alldoctorscategory(
                  name: "Cardiologist",
                  image: "assets/images/alldoctors/Mask_group4.png",
                ),
                alldoctorscategory(
                  name: "Dentist",
                  image: "assets/images/alldoctors/Mask_group5.png",
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
