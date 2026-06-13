import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_cubit.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_state.dart';
import 'package:grad_project/cubit/doctors/popular/popular_states.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesCubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesStates.dart';
import 'package:grad_project/cubit/search/Hospitals/Hospitalcubit.dart';
import 'package:grad_project/cubit/search/medicine/medicine_search.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/screens/Hospitals/allhospitals.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/screens/Doctors/alldoctors.dart';
import 'package:grad_project/screens/medicines/allmedicines.dart';
import 'package:grad_project/screens/medicines/medicine_details.dart';
import 'package:grad_project/screens/pharmacies/allpahramcies.dart';
import 'package:grad_project/screens/pharmacies/pharmacydetails.dart';
import 'package:grad_project/widgets/Medicines/medicinecard.dart';
import 'package:grad_project/widgets/doctors/category.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:grad_project/widgets/hosptials/hospital_card.dart';
import 'package:grad_project/widgets/mainscaffold.dart';
import 'package:grad_project/widgets/pharmacies/pharmacy_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  List<Doctor> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();

    context.read<PharmacyCubit>().fetchPharmacies();
    context.read<HospitalCubit>().searchHospitals(query: 'hospital', limit: 4);
    context.read<MedicineCubit>().searchMedicines(
      search: '',
      category: '',
      page: 1,
      limit: 4,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
    });
    context.read<SearchDoctorCubit>().onSearchChanged(query);
    context.read<PharmacyCubit>().searchPharmacies(query);
    if (query.isEmpty) {
      context.read<HospitalCubit>().searchHospitals(query: 'hospital');
    } else {
      context.read<HospitalCubit>().searchHospitals(query: query);
    }
    context.read<MedicineCubit>().searchMedicines(
      search: query,
      category: '',
      page: 1,
      limit: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(sw),
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, pharmacyState) {
          List<dynamic> pharmacies = [];
          if (pharmacyState is PharmacyLoaded) {
            pharmacies = pharmacyState.pharmacies;
          }

          final bool noResults =
              _isSearching &&
              _filteredDoctors.isEmpty &&
              pharmacies.isEmpty &&
              pharmacyState is! PharmacyLoading;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildSearchBar(sw, sh)),
              SliverToBoxAdapter(child: _buildCategories(sw, sh)),

              // ── Doctors ───────────────────────────────────────────--------------------------------------------------------------------------
              // ── Doctors ───────────────────────────────────────────
              SliverToBoxAdapter(
                child: BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
                  builder: (context, state) {
                    if (state is SearchDoctorInitial && !_isSearching) {
                      // show popular doctors when not searching
                      return BlocBuilder<DoctorCubit, DoctorState>(
                        builder: (context, docState) {
                          if (docState is DoctorLoading) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _sectionTitle(
                                  S.of(context).populardoctors,
                                  sw,
                                  sh,
                                ),
                                ...List.generate(
                                  3,
                                  (_) => Skeletonizer(
                                    child: Doctorcard(
                                      doctorimage: Image.asset(
                                        'assets/images/Pic.png',
                                      ),
                                      job: "Loading...",
                                      hospital: "Loading...",
                                      name: "Loading...",
                                      rate: 0,
                                      begindate: "--:--",
                                      enddate: "--:--",
                                      profile: '',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (docState is DoctorLoaded) {
                            final doctors = docState.doctors.take(4).toList();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _sectionTitle(
                                  S.of(context).populardoctors,
                                  sw,
                                  sh,
                                ),
                                ...doctors.map(
                                  (doctor) => Doctorcard(
                                    doctorimage: Image.network(doctor.image),
                                    job: doctor.job,
                                    hospital: doctor.hospital,
                                    name: doctor.name,
                                    rate: doctor.rate,
                                    begindate: doctor.beginDate,
                                    enddate: doctor.endDate,
                                    profile: doctor.profile ?? '',
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    }

                    if (state is SearchDoctorLoading) {
                      return Column(
                        children: List.generate(
                          3,
                          (_) => Skeletonizer(
                            child: Doctorcard(
                              doctorimage: Image.asset('assets/images/Pic.png'),
                              job: "Loading...",
                              hospital: "Loading...",
                              name: "Loading...",
                              rate: 0,
                              begindate: "--:--",
                              enddate: "--:--",
                              profile: '',
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is SearchDoctorSuccess) {
                      final doctors = state.doctors.take(4).toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(S.of(context).doctors, sw, sh),
                          ...doctors.map(
                            (doctor) => Doctorcard(
                              doctorimage: Image.network(doctor.image),
                              job: doctor.job,
                              hospital: doctor.hospital,
                              name: doctor.name,
                              rate: doctor.rate,
                              begindate: doctor.beginDate,
                              enddate: doctor.endDate,
                              profile: doctor.profile ?? '',
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              // ── Hospitals ─────────────────────────────────────────-------------------------------------------------------------
              SliverToBoxAdapter(
                child: BlocBuilder<HospitalCubit, HospitalState>(
                  builder: (context, state) {
                    if (state is HospitalLoading) {
                      return Skeletonizer(
                        child: HospitalCard(
                          hospital: Hospital(
                            id: '',
                            name: 'Loading...',
                            nameAr: '',
                            category: 'Loading...',
                            rating: 0,
                            openTime: '--',
                            phone: '--',
                            hasEmergency: false,
                            specialties: [],
                            latitude: 0,
                            longitude: 0,
                          ),
                        ),
                      );
                    }

                    if (state is HospitalLoaded && state.hospitals.isNotEmpty) {
                      final locale = Localizations.localeOf(
                        context,
                      ).languageCode;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _sectionTitle(S.of(context).popularhospitals, sw, sh),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.hospitals.length,
                            itemBuilder: (context, index) {
                              final hospital = state.hospitals[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.03,
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Hospitaldetails(
                                        hospital: hospital,
                                        devheight: sh,
                                      ),
                                    ),
                                  ),
                                  child: HospitalCard(hospital: hospital),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),

              // ── Pharmacies ────────────────────────────────────────------------------------------------------------------
              SliverToBoxAdapter(
                child: BlocBuilder<PharmacyCubit, PharmacyState>(
                  builder: (context, state) {
                    if (state is PharmacyLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is PharmacyError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is PharmacySearchEmpty) {
                      return const SizedBox.shrink();
                    }
                    if (state is PharmacyLoaded &&
                        state.pharmacies.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!state.isSearching)
                            _sectionTitle(
                              S.of(context).popularpharmacies,
                              sw,
                              sh,
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.pharmacies.length,
                            itemBuilder: (context, index) {
                              final pharmacy = state.pharmacies[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.03,
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PharmacyDetails(
                                        name: pharmacy.name,
                                        rate: pharmacy.rating,
                                        isopen24: pharmacy.is24Hours,
                                        devheight: sh,
                                        latitude: pharmacy.latitude ?? 0.0,
                                        longitude: pharmacy.longitude ?? 0.0,
                                      ),
                                    ),
                                  ),
                                  child: PharmacyCard(
                                    name: pharmacy.name,
                                    rate: pharmacy.rating,
                                    isopen24: pharmacy.is24Hours,
                                    latitude: pharmacy.latitude ?? 0.0,
                                    longitude: pharmacy.longitude ?? 0.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              if (noResults)
                SliverToBoxAdapter(child: _buildEmptyState(sw, sh)),

              SliverToBoxAdapter(child: SizedBox(height: sh * 0.04)),
              // ── Medicines ─────────────────────────────────────────-----------------------------------------
              SliverToBoxAdapter(
                child: BlocBuilder<MedicineCubit, MedicineState>(
                  builder: (context, state) {
                    if (state is MedicineLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is MedicineLoaded && state.medicines.isNotEmpty) {
                      final medicines = state.medicines;
                      final sw = MediaQuery.of(context).size.width;
                      final sh = MediaQuery.of(context).size.height;

                      double cardAspectRatio() {
                        final cardW = (sw - sw * 0.06 - sw * 0.025) / 2;
                        final cardH =
                            cardW * 0.65 +
                            sw * 0.050 +
                            sw * 0.008 +
                            sw * 0.039 +
                            sw * 0.005 +
                            sw * 0.039 +
                            sw * 0.101 +
                            sw * 0.04;
                        return cardW / cardH;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw * 0.03,
                              vertical: sh * 0.008,
                            ),
                            child: Text(
                              S.of(context).mostsearchedmedicines,
                              style: TextStyle(
                                fontSize: sw * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw * 0.03,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: medicines.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: sw * 0.025,
                                    mainAxisSpacing: sw * 0.025,
                                    childAspectRatio: cardAspectRatio(),
                                  ),
                              itemBuilder: (_, i) {
                                final med = medicines[i];
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MainScaffold(
                                        currentIndex: 3,
                                        child: MedicineDetails(medicine: med),
                                      ),
                                    ),
                                  ),
                                  child: MedicineCard(medicine: med),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: sh * 0.04)),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double sw) => AppBar(
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    centerTitle: true,
    title: Text(
      S.of(context).findwhatyouneed,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.046),
    ),
    toolbarHeight: sw * 0.18,
    backgroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(height: 1, color: Colors.grey.shade300),
    ),
  );

  Widget _buildSearchBar(double sw, double sh) => Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.015),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.08),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _search,
        style: TextStyle(fontSize: sw * 0.038),
        decoration: InputDecoration(
          hintText: S.of(context).searching,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: sw * 0.038,
          ),
          prefixIcon: Icon(Icons.search, size: sw * 0.055),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sw * 0.08),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: sh * 0.015),
        ),
      ),
    ),
  );

  Widget _buildCategories(double sw, double sh) {
    final items = [
      {
        'label': S.of(context).doctors,
        'image': 'assets/images/search/Maskgroup.png',
        'dest': () => const Alldoctors(),
      },
      {
        'label': S.of(context).pharmacies,
        'image': 'assets/images/search/Maskgroup2.png',
        'dest': () => const Allpahramcies(),
      },
      {
        'label': S.of(context).hospitals,
        'image': 'assets/images/search/Maskgroup4.png',
        'dest': () => const Allhospitals(),
      },
      {
        'label': S.of(context).medicines,
        'image': 'assets/images/search/Maskgroup3.png',
        'dest': () => const Allmedicines(),
      },
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => (item['dest'] as Function)()),
            ),
            child: alldoctorscategory(
              name: item['label'] as String,
              image: item['image'] as String,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sectionTitle(String title, double sw, double sh) => Padding(
    padding: EdgeInsets.fromLTRB(sw * 0.04, sh * 0.018, sw * 0.04, sh * 0.006),
    child: Text(
      title,
      style: TextStyle(fontSize: sw * 0.045, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildEmptyState(double sw, double sh) => Padding(
    padding: EdgeInsets.symmetric(vertical: sh * 0.08),
    child: Column(
      children: [
        SizedBox(
          height: sw * 0.12,
          width: sw * 0.12,
          child: Image.asset('assets/images/alldoctors/search.png'),
        ),
        SizedBox(height: sh * 0.02),
        Text(
          S.of(context).sorrynoresultfound,
          style: TextStyle(fontSize: sw * 0.045, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: sh * 0.01),
        Text(
          S.of(context).trydifferentsearchterm,
          style: TextStyle(fontSize: sw * 0.038, color: Colors.grey),
        ),
      ],
    ),
  );
}
