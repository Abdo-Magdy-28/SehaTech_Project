import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/popular/popular_states.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesCubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/screens/Hospitals/allhospitals.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/screens/Doctors/alldoctors.dart';
import 'package:grad_project/screens/medicines/allmedicines.dart';
import 'package:grad_project/screens/pharmacies/allpahramcies.dart';
import 'package:grad_project/screens/pharmacies/pharmacydetails.dart';
import 'package:grad_project/widgets/doctors/category.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:grad_project/widgets/hosptials/hospital_card.dart';
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
  List<Hospital> _filteredHospitals = [];

  final List<Hospital> _hospitals = [
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

  final List<Doctor> _allDoctors = [
    Doctor(
      name: 'Youssef Ali',
      job: 'Neurologist',
      hospital: 'El-Demerdash Hospital',
      image: 'assets/images/Pic.png',
      rate: 4.5,
      beginDate: '10:30am',
      endDate: '5:30pm',
    ),
    Doctor(
      name: 'Ahmed Hassan',
      job: 'Cardiologist',
      hospital: 'Ain Shams Hospital',
      image: 'assets/images/Pic2.png',
      rate: 4.2,
      beginDate: '9:00am',
      endDate: '4:00pm',
    ),
    Doctor(
      name: 'Omar Khaled',
      job: 'Dentist',
      hospital: 'Smile Care Clinic',
      image: 'assets/images/Pic4.png',
      rate: 4.1,
      beginDate: '8:30am',
      endDate: '2:30pm',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _allDoctors;
    _filteredHospitals = _hospitals;
    context.read<PharmacyCubit>().fetchPharmacies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredDoctors = _allDoctors
          .where((d) => d.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filteredHospitals = _hospitals
          .where((h) => h.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    context.read<PharmacyCubit>().searchPharmacies(query);
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
          // ── تحديد بيانات الصيدليات ─────────────────────────────
          List<dynamic> pharmacies = [];

          if (pharmacyState is PharmacyLoaded) {
            pharmacies = pharmacyState.pharmacies;
          }

          // ── حساب noResults بشكل صحيح (مصدر واحد للـ empty state) ─
          final bool noResults =
              _isSearching &&
              _filteredDoctors.isEmpty &&
              _filteredHospitals.isEmpty &&
              pharmacies.isEmpty &&
              pharmacyState is! PharmacyLoading;

          return CustomScrollView(
            slivers: [
              // ── Search bar ───────────────────────────────────────
              SliverToBoxAdapter(child: _buildSearchBar(sw, sh)),

              // ── Category shortcuts ───────────────────────────────
              SliverToBoxAdapter(child: _buildCategories(sw, sh)),

              // ── Section: Doctors ──────────────────────────────────
              // FIX #1: كلا العنصرين (العنوان + القائمة) محاطَين بـ if (!_isSearching)
              if (!_isSearching)
                SliverToBoxAdapter(
                  child: _sectionTitle(S.of(context).populardoctors, sw, sh),
                ),
              if (!_isSearching)
                BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorLoading) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Skeletonizer(
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
                          childCount: 5,
                        ),
                      );
                    } else if (state is DoctorLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final doctor = state.doctors[index];
                          return Doctorcard(
                            doctorimage: Image.network(doctor.image),
                            job: doctor.job,
                            hospital: doctor.hospital,
                            name: doctor.name,
                            rate: doctor.rate,
                            begindate: doctor.beginDate,
                            enddate: doctor.endDate,
                            profile: doctor.profile ?? '',
                          );
                        }, childCount: state.doctors.length),
                      );
                    } else if (state is DoctorError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text("Error: ${state.message}")),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                        child: Center(child: Text("No data")),
                      );
                    }
                  },
                ),

              // ── Section: Hospitals ────────────────────────────────
              if (_filteredHospitals.isNotEmpty) ...[
                if (!_isSearching)
                  SliverToBoxAdapter(
                    child: _sectionTitle(
                      S.of(context).popularhospitals,
                      sw,
                      sh,
                    ),
                  ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => _buildHospitalTile(_filteredHospitals[i], sw, sh),
                    childCount: _filteredHospitals.length,
                  ),
                ),
              ],

              // ── Section: Pharmacies ────────────────────────────────
              // FIX #2: استخدام Column بدل ListView داخل SliverToBoxAdapter
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

                    // FIX #3: حالة SearchEmpty تُعرض هنا فقط إذا كان هناك نتائج في مكان آخر،
                    // أما إذا كان noResults = true فالـ empty state الموحد يظهر في الأسفل
                    if (state is PharmacySearchEmpty) {
                      return const SizedBox.shrink(); // noResults يتكفل بالعرض
                    }

                    if (state is PharmacyLoaded &&
                        state.pharmacies.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!state.isSearching)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.of(context).popularpharmacies,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            // FIX #2: NeverScrollableScrollPhysics لمنع التعارض مع CustomScrollView
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.pharmacies.length,
                            itemBuilder: (context, index) {
                              final pharmacy = state.pharmacies[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
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

              // ── FIX #3: Empty state موحد (مصدر واحد فقط) ───────────
              if (noResults)
                SliverToBoxAdapter(child: _buildEmptyState(sw, sh)),

              SliverToBoxAdapter(child: SizedBox(height: sh * 0.04)),
            ],
          );
        },
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────
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

  // ── Search bar ───────────────────────────────────────────────────
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

  // ── Category row ─────────────────────────────────────────────────
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

  // ── Section title ────────────────────────────────────────────────
  Widget _sectionTitle(String title, double sw, double sh) => Padding(
    padding: EdgeInsets.fromLTRB(sw * 0.04, sh * 0.018, sw * 0.04, sh * 0.006),
    child: Text(
      title,
      style: TextStyle(fontSize: sw * 0.045, fontWeight: FontWeight.bold),
    ),
  );

  // ── Hospital tile ────────────────────────────────────────────────
  Widget _buildHospitalTile(Hospital h, double sw, double sh) => Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Hospitaldetails(
            name: h.name,
            rate: h.rating,
            opentime: h.openTime,
            closetime: h.closeTime,
            devheight: sh,
            category: h.category,
          ),
        ),
      ),
      child: HospitalCard(
        rate: h.rating,
        name: h.name,
        category: h.category,
        opendate: h.openTime,
        closedate: h.closeTime,
      ),
    ),
  );

  // ── Empty state ──────────────────────────────────────────────────
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
