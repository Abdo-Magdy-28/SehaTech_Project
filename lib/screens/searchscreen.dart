import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/models/medicine.dart';
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
import 'package:grad_project/widgets/Medicines/medicinecard.dart';
import 'package:grad_project/widgets/pharmacies/pharmacy_card.dart';

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
  List<Pharmacy> _filteredPharmacies = [];

  final List<Pharmacy> _pharmacies = [
    Pharmacy(name: 'El-Amawy', rating: 4.8, is24Hours: true),
    Pharmacy(name: 'Seif Pharmacy', rating: 4.6, is24Hours: true),
    Pharmacy(name: 'El-Ezaby Pharmacy', rating: 4.7, is24Hours: false),
  ];

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
    _filteredPharmacies = _pharmacies;
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
      _filteredPharmacies = _pharmacies
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  late final List<Medicine> _medicines;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    final bool noResults =
        _isSearching &&
        _filteredDoctors.isEmpty &&
        _filteredHospitals.isEmpty &&
        _filteredPharmacies.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(sw),
      // ── Single CustomScrollView — no nested scrollable widgets ──
      body: CustomScrollView(
        slivers: [
          // ── Search bar ───────────────────────────────────────────
          SliverToBoxAdapter(child: _buildSearchBar(sw, sh)),

          // ── Category shortcuts ───────────────────────────────────
          SliverToBoxAdapter(child: _buildCategories(sw, sh)),

          // ── Section: Doctors ─────────────────────────────────────
          if (!_isSearching)
            SliverToBoxAdapter(
              child: _sectionTitle(S.of(context).populardoctors, sw, sh),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _buildDoctorTile(_filteredDoctors[i], sw, sh),
              childCount: _filteredDoctors.length,
            ),
          ),

          // ── Section: Hospitals ───────────────────────────────────
          if (!_isSearching)
            SliverToBoxAdapter(
              child: _sectionTitle(S.of(context).popularhospitals, sw, sh),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _buildHospitalTile(_filteredHospitals[i], sw, sh),
              childCount: _filteredHospitals.length,
            ),
          ),

          // ── Section: Pharmacies ──────────────────────────────────
          if (!_isSearching)
            SliverToBoxAdapter(
              child: _sectionTitle(S.of(context).popularpharmacies, sw, sh),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _buildPharmacyTile(_filteredPharmacies[i], sw, sh),
              childCount: _filteredPharmacies.length,
            ),
          ),

          // ── Empty state ──────────────────────────────────────────
          if (noResults) SliverToBoxAdapter(child: _buildEmptyState(sw, sh)),

          SliverToBoxAdapter(child: SizedBox(height: sh * 0.04)),
        ],
      ),
    );
  }

  // ── aspect ratio ─────────────────────────────────────────────────
  // horizontal padding = sw*0.045 each side = sw*0.09 total
  // gap between cards  = sw*0.025
  // cardW = (sw - sw*0.09 - sw*0.025) / 2
  //
  // card height sections (mirrors medicinecard.dart exactly):
  //   image SizedBox : cardW * 0.65
  //   name row       : sw * 0.033 * 1.5  ≈ sw * 0.050
  //   gap            : sw * 0.008
  //   description    : sw * 0.026 * 1.5  ≈ sw * 0.039
  //   gap            : sw * 0.005
  //   component      : sw * 0.026 * 1.5  ≈ sw * 0.039
  //   view btn       : sw * 0.025*2 + sw*0.034*1.5 ≈ sw * 0.101
  //   extra buffer   : sw * 0.03   (spacer + rounding safety)
  double _medicineCardRatio(double sw) {
    final cardW = (sw - sw * 0.09 - sw * 0.025) / 2;
    final cardH =
        cardW * 0.65 +
        sw *
            0.050 // name
            +
        sw *
            0.008 // gap
            +
        sw *
            0.039 // description
            +
        sw *
            0.005 // gap
            +
        sw *
            0.039 // component
            +
        sw *
            0.101 // view button
            +
        sw * 0.04; // safety buffer
    return cardW / cardH;
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

  // ── Doctor tile ──────────────────────────────────────────────────
  Widget _buildDoctorTile(Doctor d, double sw, double sh) => Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.03),

    child: Doctorcard(
      devheight: sh,
      doctorimage: Image.asset('assets/images/Pic.png'),
      job: d.job,
      hospital: d.hospital,
      name: d.name,
      rate: d.rate,
      begindate: d.beginDate,
      enddate: d.endDate,
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

  // ── Pharmacy tile ────────────────────────────────────────────────
  Widget _buildPharmacyTile(Pharmacy p, double sw, double sh) => Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PharmacyDetails(
            name: p.name,
            rate: p.rating,
            isopen24: p.is24Hours,
            devheight: sh,
          ),
        ),
      ),
      child: PharmacyCard(rate: p.rating, name: p.name, isopen24: p.is24Hours),
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
