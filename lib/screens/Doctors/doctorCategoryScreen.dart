import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctorCategoryCubit.dart';
import 'package:grad_project/cubit/doctors/cubit/doctorCategoryStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/services/search%20services/doctors/speciallitiesService.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryDoctorsScreen extends StatelessWidget {
  final String speciality; // English API key
  final String displayName; // localized short label for AppBar

  const CategoryDoctorsScreen({
    super.key,
    required this.speciality,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryDoctorsCubit(specialitiesService: SpecialitiesService())
            ..loadDoctors(speciality),
      child: _CategoryDoctorsView(
        speciality: speciality,
        displayName: displayName,
      ),
    );
  }
}

class _CategoryDoctorsView extends StatefulWidget {
  final String speciality;
  final String displayName;

  const _CategoryDoctorsView({
    required this.speciality,
    required this.displayName,
  });

  @override
  State<_CategoryDoctorsView> createState() => _CategoryDoctorsViewState();
}

class _CategoryDoctorsViewState extends State<_CategoryDoctorsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryDoctorsCubit>();
    final devheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Text(
          widget.displayName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: Column(
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
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) => cubit.filterDoctors(query),
                decoration: InputDecoration(
                  focusColor: const Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xff0D5FA7)),
                  ),
                  hintText: S.of(context).searching,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      cubit.filterDoctors('');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),

          // ========================================
          // 📋 CONTENT
          // ========================================
          Expanded(
            child: BlocBuilder<CategoryDoctorsCubit, CategoryDoctorsState>(
              builder: (context, state) {
                // ⏳ LOADING
                if (state is CategoryDoctorsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            title: Container(
                              height: 14,
                              width: 120,
                              color: Colors.grey,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 12,
                                  width: 100,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            trailing: Container(
                              height: 12,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // ✅ SUCCESS
                if (state is CategoryDoctorsSuccess) {
                  final doctors = state.filtered;

                  if (doctors.isEmpty) {
                    return _buildEmptySearch(context);
                  }

                  return ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return _buildDoctorCard(
                        doctors[index],
                        devheight,
                        context,
                      );
                    },
                  );
                }

                // 📭 EMPTY from API
                if (state is CategoryDoctorsEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          S.of(context).nodoctorsincategory,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                // ❌ ERROR
                if (state is CategoryDoctorsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => cubit.retry(widget.speciality),
                          child: Text(S.of(context).tryagain),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          const SizedBox(height: 60),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/images/alldoctors/search.png'),
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).sorrynoresultfound,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).trydifferentsearchterm,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(
    Doctor doctor,
    double devheight,
    BuildContext context,
  ) {
    Image doctorImage;
    final String imageUrl = doctor.image.trim();
    if (imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
      doctorImage = Image.network(
        imageUrl,
        width: 37,
        height: 37,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset('assets/images/Pic.png'),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
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
      doctorImage = Image.asset('assets/images/Pic.png');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Doctorcard(
        doctorimage: doctorImage,
        job: doctor.job,
        hospital: doctor.hospital,
        name: doctor.name,
        rate: doctor.rate,
        begindate: doctor.beginDate,
        enddate: doctor.endDate,
        profile: doctor.profile ?? "",
      ),
    );
  }
}
