import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_cubit.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_state.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/services/search%20services/doctors/search_service.dart';
import 'package:grad_project/widgets/doctors/doctor_details.dart';
import 'package:grad_project/widgets/doctors/category.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';

class Alldoctors extends StatefulWidget {
  const Alldoctors({super.key});

  @override
  State<Alldoctors> createState() => _AlldoctorsState();
}

class _AlldoctorsState extends State<Alldoctors> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => SearchDoctorCubit(searchService: SearchService()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SearchDoctorCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                "Doctors",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                // ========================================
                // 🔍 SEARCH BAR
                // ========================================
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
                      controller: searchController,
                      onChanged: (query) => cubit.onSearchChanged(query),
                      decoration: InputDecoration(
                        focusColor: Color(0xff0D5FA7),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xff0D5FA7)),
                        ),
                        hintText: "Search...",
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            cubit.clearSearch();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),

                // ========================================
                // 📋 BLOC BUILDER
                // ========================================
                BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
                  builder: (context, state) {
                    // ============================
                    // 🟡 INITIAL — Categories only
                    // ============================
                    if (state is SearchDoctorInitial) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Categories
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildCategory(
                                  "Neurologist",
                                  "assets/images/alldoctors/Mask_group.png",
                                ),
                                _buildCategory(
                                  "Psychiatrist",
                                  "assets/images/alldoctors/Mask_group2.png",
                                ),
                                _buildCategory(
                                  "Dermatologist",
                                  "assets/images/alldoctors/Mask_group3.png",
                                ),
                                _buildCategory(
                                  "Cardiologist",
                                  "assets/images/alldoctors/Mask_group4.png",
                                ),
                                _buildCategory(
                                  "Dentist",
                                  "assets/images/alldoctors/Mask_group5.png",
                                ),
                              ],
                            ),
                          ),

                          // Hint text
                          SizedBox(height: 100),
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Search for doctors by name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    // ============================
                    // ⏳ LOADING
                    // ============================
                    if (state is SearchDoctorLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff0D5FA7),
                          ),
                        ),
                      );
                    }

                    // ============================
                    // ✅ SUCCESS — API Results
                    // ============================
                    if (state is SearchDoctorSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return _buildDoctorCard(doctor, devheight);
                        },
                      );
                    }

                    // ============================
                    // 🔍 EMPTY — No results
                    // ============================
                    if (state is SearchDoctorEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'assets/images/alldoctors/search.png',
                              ),
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
                      );
                    }

                    // ============================
                    // ❌ ERROR
                    // ============================
                    if (state is SearchDoctorError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.error, size: 64, color: Colors.red),
                              SizedBox(height: 16),
                              Text(
                                state.message,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  searchController.clear();
                                  cubit.clearSearch();
                                },
                                child: Text("Try Again"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ========================================
  // 🔧 Helper: Build Category
  // ========================================
  Widget _buildCategory(String name, String image) {
    return GestureDetector(
      onTap: () {
        // You can handle category filtering later
      },
      child: alldoctorscategory(name: name, image: image),
    );
  }

  // ========================================
  // 🔧 Helper: Build Doctor Card
  // ========================================
  Widget _buildDoctorCard(Doctor doctor, double devheight) {
    Image doctorImage;
    final String imageUrl = doctor.image.trim();
    if (imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
      doctorImage = Image.network(
        imageUrl,
        width: 37,
        height: 37,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset('assets/images/Pic.png'),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 37,
            height: 37,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xff0D61EC),
            ),
          );
        },
      );
    } else {
      // ✅ empty string or local path — use asset fallback
      doctorImage = Image.asset('assets/images/Pic.png');
    }

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
          doctorimage: doctorImage,
          job: doctor.job,
          hospital: doctor.hospital,
          name: doctor.name,
          rate: doctor.rate,
          begindate: doctor.beginDate,
          enddate: doctor.endDate,
        ),
      ),
    );
  }
}
