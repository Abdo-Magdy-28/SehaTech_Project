import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_cubit.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_state.dart';
import 'package:grad_project/cubit/doctors/cubit/speciallitiesCubit.dart';
import 'package:grad_project/cubit/doctors/cubit/speciallitiesStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/screens/Doctors/doctorCategoryScreen.dart';
import 'package:grad_project/screens/Doctors/speciallitiesChip.dart';
import 'package:grad_project/services/search%20services/doctors/search_service.dart';
import 'package:grad_project/services/search%20services/doctors/speciallitiesService.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Alldoctors extends StatefulWidget {
  const Alldoctors({super.key});

  @override
  State<Alldoctors> createState() => _AlldoctorsState();
}

class _AlldoctorsState extends State<Alldoctors> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final specialities = getSpecialities(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchDoctorCubit(searchService: SearchService()),
        ),
        BlocProvider(
          create: (_) =>
              SpecialitiesCubit(specialitiesService: SpecialitiesService())
                ..loadAllDoctors(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final searchCubit = context.read<SearchDoctorCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                S.of(context).doctors,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(height: 1, color: Colors.grey),
              ),
            ),
            body: ListView(
              children: [
                // ════════════════════════════════════════
                // 🔍 SEARCH BAR
                // ════════════════════════════════════════
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (q) => searchCubit.onSearchChanged(q),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xff0D5FA7),
                          ),
                        ),
                        hintText: S.of(context).searching,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            searchCubit.clearSearch();
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

                // ════════════════════════════════════════
                // 🏷️ CATEGORY BAR — always visible
                // ════════════════════════════════════════
                SizedBox(
                  height: 108,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: specialities.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 4),
                    itemBuilder: (context, index) {
                      final item = specialities[index];
                      return SpecialityChip(
                        label: item.label,
                        icon: item.icon,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryDoctorsScreen(
                              speciality: item.apiKey,
                              displayName: item.label,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ════════════════════════════════════════
                // 📋 SEARCH RESULTS — shown when searching
                // ════════════════════════════════════════
                BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
                  builder: (context, searchState) {
                    if (searchState is SearchDoctorInitial) {
                      return const SizedBox.shrink();
                    }
                    if (searchState is SearchDoctorLoading) {
                      return _buildSkeletonList();
                    }
                    if (searchState is SearchDoctorSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchState.doctors.length,
                        itemBuilder: (_, i) =>
                            _buildDoctorCard(searchState.doctors[i], devheight),
                      );
                    }
                    if (searchState is SearchDoctorEmpty) {
                      return _buildEmptySearch(context);
                    }
                    if (searchState is SearchDoctorError) {
                      return _buildSearchError(
                        context,
                        searchState.message,
                        searchCubit,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // ════════════════════════════════════════
                // 🏥 ALL DOCTORS — shown on initial state
                // ════════════════════════════════════════
                BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
                  builder: (context, searchState) {
                    if (searchState is! SearchDoctorInitial) {
                      return const SizedBox.shrink();
                    }

                    return BlocBuilder<SpecialitiesCubit, SpecialitiesState>(
                      builder: (context, state) {
                        if (state is SpecialitiesLoading ||
                            state is AllDoctorsLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  8,
                                  16,
                                  4,
                                ),
                                child: Text(
                                  S.of(context).alldoctors,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              _buildSkeletonList(),
                            ],
                          );
                        }

                        if (state is AllDoctorsSuccess) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  8,
                                  16,
                                  4,
                                ),
                                child: Text(
                                  S.of(context).alldoctors,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.doctors.length,
                                itemBuilder: (_, i) => _buildDoctorCard(
                                  state.doctors[i],
                                  devheight,
                                ),
                              ),
                            ],
                          );
                        }

                        if (state is AllDoctorsError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    state.message,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () => context
                                        .read<SpecialitiesCubit>()
                                        .retry(),
                                    child: Text(S.of(context).tryagain),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ════════════════════════════════════════
  // 🔧 Doctor card
  // ════════════════════════════════════════
  Widget _buildDoctorCard(Doctor doctor, double devheight) {
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

  // ════════════════════════════════════════
  // 🔧 Skeleton list
  // ════════════════════════════════════════
  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          5,
          (_) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                title: Container(height: 14, width: 120, color: Colors.grey),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Container(height: 12, width: 80, color: Colors.grey),
                    const SizedBox(height: 4),
                    Container(height: 12, width: 100, color: Colors.grey),
                  ],
                ),
                trailing: Container(height: 12, width: 30, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════
  // 🔧 Empty search
  // ════════════════════════════════════════
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

  Widget _buildSearchError(
    BuildContext context,
    String msg,
    SearchDoctorCubit cubit,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error, size: 56, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              msg,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _searchController.clear();
                cubit.clearSearch();
              },
              child: Text(S.of(context).tryagain),
            ),
          ],
        ),
      ),
    );
  }
}
