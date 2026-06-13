import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grad_project/cubit/search/Hospitals/Hospitalcubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/widgets/hosptials/hospital_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Allhospitals extends StatefulWidget {
  const Allhospitals({super.key});

  @override
  State<Allhospitals> createState() => _AllhospitalsState();
}

class _AllhospitalsState extends State<Allhospitals> {
  final TextEditingController searchController = TextEditingController();
  String currentoption = '';
  Position? _userPosition;
  List<Hospital> _sortedHospitals = [];

  @override
  void initState() {
    super.initState();
    context.read<HospitalCubit>().searchHospitals(query: 'hospital');
  }

  void _onSearch(String query) {
    setState(() => _sortedHospitals = []);
    if (query.isEmpty) {
      context.read<HospitalCubit>().searchHospitals(query: 'hospital');
    } else {
      context.read<HospitalCubit>().searchHospitals(query: query);
    }
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) =>
            _buildSheet(context, setModalState),
      ),
    );
  }

  Future<void> _sortByLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() => _userPosition = position);

      final state = context.read<HospitalCubit>().state;
      if (state is HospitalLoaded) {
        final sorted = List<Hospital>.from(state.hospitals);
        sorted.sort((a, b) {
          final distA = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            a.latitude,
            a.longitude,
          );
          final distB = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            b.latitude,
            b.longitude,
          );
          return distA.compareTo(distB);
        });
        setState(() => _sortedHospitals = sorted);
      }
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  void _sortByName() {
    final state = context.read<HospitalCubit>().state;
    if (state is HospitalLoaded) {
      final sorted = List<Hospital>.from(state.hospitals);
      sorted.sort((a, b) => a.name.compareTo(b.name));
      setState(() => _sortedHospitals = sorted);
    }
  }

  Widget _buildSheet(BuildContext context, StateSetter setModalState) {
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
          Text(
            'Sort by',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () =>
                setModalState(() => currentoption = S.of(context).location),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).locationnearestfirst,
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == S.of(context).location)
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
            onTap: () =>
                setModalState(() => currentoption = S.of(context).name),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).alphabetfromatoz,
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == S.of(context).name)
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
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (currentoption == S.of(context).name) {
                  _sortByName();
                } else if (currentoption == S.of(context).location) {
                  _sortByLocation();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2260FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).save,
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
          S.of(context).hospitals,
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
                onChanged: _onSearch,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: S.of(context).searching,
                  prefixIcon: Icon(Icons.search),
                  focusColor: Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff0D5FA7)),
                  ),
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
                Container(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentoption == ''
                        ? S.of(context).popularhospitals
                        : currentoption == S.of(context).location
                        ? S.of(context).bylocation
                        : currentoption == S.of(context).name
                        ? S.of(context).byname
                        : S.of(context).popularhospitals,
                    style: TextStyle(
                      color: Color(0xff111111).withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: _showSortSheet,
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
          SizedBox(height: 8),
          BlocBuilder<HospitalCubit, HospitalState>(
            builder: (context, state) {
              if (state is HospitalLoading) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => Skeletonizer(
                    child: HospitalCard(
                      hospital: Hospital(
                        latitude: 0.0,
                        longitude: 0.0,
                        id: '',
                        name: 'Loading...',
                        nameAr: 'جاري التحميل',
                        category: 'Loading...',
                        rating: 0,
                        openTime: '--',
                        phone: '--',
                        hasEmergency: false,
                        specialties: [],
                      ),
                    ),
                  ),
                );
              }

              if (state is HospitalError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state is HospitalLoaded) {
                final hospitals = _sortedHospitals.isNotEmpty
                    ? _sortedHospitals
                    : state.hospitals;
                if (hospitals.isEmpty) {
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
                          S.of(context).sorrynoresultfound,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          S.of(context).trydifferentsearchterm,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hospitals.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: HospitalCard(hospital: hospitals[index]),
                    );
                  },
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
