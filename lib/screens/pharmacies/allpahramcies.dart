import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesCubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/widgets/pharmacies/pharmacy_card.dart';
import 'package:grad_project/screens/pharmacies/pharmacydetails.dart';

class Allpahramcies extends StatefulWidget {
  const Allpahramcies({super.key});

  @override
  State<Allpahramcies> createState() => _AllpahramciesState();
}

class _AllpahramciesState extends State<Allpahramcies> {
  TextEditingController searchController = TextEditingController();
  String currentoption = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<PharmacyCubit>().fetchPharmacies();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<PharmacyCubit>().searchPharmacies(query);
    });
  }

  void sortByName(List<Pharmacy> pharmacies) {
    pharmacies.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortByRating(List<Pharmacy> pharmacies) {
    pharmacies.sort((a, b) => b.rating.compareTo(a.rating));
  }

  Future<void> sortByNearest() async {
    Navigator.pop(context);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;
      context.read<PharmacyCubit>().fetchNearbyPharmacies(
        lat: pos.latitude,
        lng: pos.longitude,
      );
    } catch (e) {
      // optionally show a snackbar
    }
  }

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
                currentoption = S.of(context).location;
              });
              sortByNearest();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).location, style: TextStyle(fontSize: 16)),
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
          S.of(context).pharmacies,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: Column(
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
                onChanged: onSearchChanged,
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff0D5FA7)),
                  ),
                  hintText: S.of(context).searching,
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
                    currentoption == '' ||
                            currentoption == S.of(context).location
                        ? S.of(context).nearestfirst
                        : S.of(context).location,
                    style: TextStyle(
                      color: Color(0xff111111).withValues(alpha: 0.6),
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
          Expanded(
            child: BlocBuilder<PharmacyCubit, PharmacyState>(
              builder: (context, state) {
                if (state is PharmacyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PharmacyError) {
                  return Center(child: Text(state.message));
                }

                if (state is PharmacySearchEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          S.of(context).trydifferentsearchterm,
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

                if (state is PharmacyLoaded) {
                  return ListView(
                    children: [
                      if (!state.isSearching)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).popularpharmacies,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.pharmacies.length,
                        itemBuilder: (context, index) {
                          final pharmacy = state.pharmacies[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PharmacyDetails(
                                      name: pharmacy.name,
                                      rate: pharmacy.rating,
                                      isopen24: pharmacy.is24Hours,
                                      devheight: devheight,
                                      latitude: pharmacy.latitude,
                                      longitude: pharmacy.longitude,
                                    ),
                                  ),
                                );
                              },
                              child: PharmacyCard(
                                name: pharmacy.name,
                                rate: pharmacy.rating,
                                isopen24: pharmacy.is24Hours,
                                longitude: pharmacy.longitude ?? 0,
                                latitude: pharmacy.latitude ?? 0,
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
        ],
      ),
    );
  }
}
