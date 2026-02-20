import 'package:flutter/material.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/screens/doctor_details.dart';
import 'package:grad_project/widgets/doctor_card.dart';

class ScreenCategory extends StatefulWidget {
  final List<Doctor> categoryDoctors;
  const ScreenCategory({super.key, required this.categoryDoctors});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  TextEditingController searchController = TextEditingController();
  String currentoption = '';
  late List<Doctor> filteredDoctors;
  bool isSearching = false;
  Widget buildsheet(BuildContext context, StateSetter setModalState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sort by',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setModalState(() {
                currentoption = 'location';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location: nearest first",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'location')
                    SizedBox(
                      height: 16,
                      child: Image.asset(
                        'assets/images/alldoctors/elements.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 1),
          InkWell(
            onTap: () {
              setModalState(() {
                currentoption = 'rating';
              });

              sortrate();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rating: The Best First",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'rating')
                    SizedBox(
                      height: 16,
                      child: Image.asset(
                        'assets/images/alldoctors/elements.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 1),
          InkWell(
            onTap: () {
              setModalState(() {
                currentoption = 'price';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: From Low To Hight",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'price')
                    SizedBox(
                      height: 16,
                      child: Image.asset(
                        'assets/images/alldoctors/elements.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 1),
          InkWell(
            onTap: () {
              setModalState(() {
                currentoption = 'name';
              });

              sortname();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Alphabet: From A>Z", style: TextStyle(fontSize: 16)),
                  if (currentoption == 'name')
                    SizedBox(
                      height: 16,
                      child: Image.asset(
                        'assets/images/alldoctors/elements.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 1),
          InkWell(
            onTap: () {
              setModalState(() {
                currentoption = 'experience';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience: More Experience First",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'experience')
                    SizedBox(
                      height: 16,
                      child: Image.asset(
                        'assets/images/alldoctors/elements.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2260FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredDoctors = widget.categoryDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void sortname() {
    setState(() {
      filteredDoctors.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortrate() {
    setState(() {
      filteredDoctors.sort((a, b) => b.rate.compareTo(a.rate));
    });
  }

  @override
  void initState() {
    super.initState();
    filteredDoctors = widget.categoryDoctors;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffDDDDDD),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          "assets/images/alldoctors/sort.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "By location",
                    style: TextStyle(
                      color: Color(0xff111111).withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, StateSetter setModalState) =>
                            buildsheet(context, setModalState),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffDDDDDD),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          "assets/images/alldoctors/filter.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              final doctor = filteredDoctors[index];

              return GestureDetector(
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
                child: Padding(
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
