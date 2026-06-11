import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/search/medicine/medicine_search.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/medicine/medicinemodel.dart';
import 'package:grad_project/screens/medicines/medicine_details.dart';
import 'package:grad_project/widgets/mainscaffold.dart';
import 'package:grad_project/widgets/Medicines/medicinecard.dart';

class Allmedicines extends StatefulWidget {
  const Allmedicines({super.key});

  @override
  State<Allmedicines> createState() => _AllmedicinesState();
}

class _AllmedicinesState extends State<Allmedicines> {
  final TextEditingController _searchController = TextEditingController();
  // ── Create the cubit HERE, not inside build() ──────────────────────
  final MedicineCubit _cubit = MedicineCubit();

  String? _selectedCategoryEn;
  Timer? _debounce;
  static const int _limit = 20;

  late List<Map<String, dynamic>> _categories;
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categories = [
      {'label': S.of(context).eczema, 'en': 'Eczema', 'icon': Icons.healing},
      {'label': S.of(context).nasal, 'en': 'Nasal', 'icon': Icons.air},
      {'label': S.of(context).fever, 'en': 'Fever', 'icon': Icons.thermostat},
      {
        'label': S.of(context).infection,
        'en': 'Infection',
        'icon': Icons.coronavirus,
      },
      {
        'label': S.of(context).spasm,
        'en': 'Spasm',
        'icon': Icons.electric_bolt,
      },
      {
        'label': S.of(context).pain,
        'en': 'Pain',
        'icon': Icons.medical_services,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    // Safe: _cubit exists already, no need for postFrameCallback
    _fetch();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _fetch() {
    _cubit.searchMedicines(
      search: _searchController.text.trim(),
      category: _selectedCategoryEn ?? '',
      page: 1,
      limit: _limit,
    );
  }

  // ── Fires only 600 ms after the user stops typing ───────────────────
  void _onSearchChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), _fetch);
  }

  void _toggleCategory(String en, String label) {
    setState(() {
      _selectedCategoryEn = (_selectedCategoryEn == en) ? null : en;
    });
    _fetch(); // immediate, no debounce needed for tap
  }

  double _cardAspectRatio(double sw) {
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

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    // ── Provide the already-created cubit, don't create a new one ──────
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).medicines,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.048),
          ),
          toolbarHeight: sw * 0.18,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.grey),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Search bar ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.04,
                vertical: sh * 0.015,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  // ── Also trigger immediately on keyboard "done" / submit ──
                  onSubmitted: (_) {
                    _debounce?.cancel();
                    _fetch();
                  },
                  style: TextStyle(fontSize: sw * 0.038),
                  decoration: InputDecoration(
                    hintText: S.of(context).searching,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: sw * 0.038,
                    ),
                    prefixIcon: Icon(Icons.search, size: sw * 0.055),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sw * 0.08),
                      borderSide: const BorderSide(color: Color(0xff0D5FA7)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sw * 0.08),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: sh * 0.015),
                  ),
                ),
              ),
            ),

            // ── Category chips ────────────────────────────────────────
            SizedBox(
              height: sw * 0.22,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => SizedBox(width: sw * 0.025),
                itemBuilder: (_, i) {
                  final cat = _categories[i];
                  final sel = _selectedCategoryEn == cat['en'];
                  return GestureDetector(
                    onTap: () => _toggleCategory(
                      cat['en'] as String,
                      cat['label'] as String,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: sw * 0.14,
                          height: sw * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(sw * 0.03),
                            color: sel
                                ? const Color(0xff2260FF)
                                : const Color(0xffEEF2FF),
                          ),
                          child: Center(
                            child: Icon(
                              cat['icon'] as IconData,
                              color: sel
                                  ? Colors.white
                                  : const Color(0xff2260FF),
                              size: sw * 0.065,
                            ),
                          ),
                        ),
                        SizedBox(height: sw * 0.015),
                        Text(
                          cat['label'] as String,
                          style: TextStyle(
                            fontSize: sw * 0.028,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            color: sel
                                ? const Color(0xff2260FF)
                                : const Color(0xff33384B),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: sh * 0.015),

            // ── BLoC-driven content ───────────────────────────────────
            BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: sh * 0.1),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is MedicineError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: sh * 0.1),
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          fontSize: sw * 0.04,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                }

                if (state is MedicineLoaded) {
                  final medicines = state.medicines;

                  if (medicines.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sh * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: sw * 0.12,
                            width: sw * 0.12,
                            child: Image.asset(
                              'assets/images/alldoctors/search.png',
                            ),
                          ),
                          SizedBox(height: sh * 0.02),
                          Text(
                            S.of(context).sorrynoresultfound,
                            style: TextStyle(
                              fontSize: sw * 0.045,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: sh * 0.01),
                          Text(
                            S.of(context).trydifferentsearchterm,
                            style: TextStyle(
                              fontSize: sw * 0.038,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_searchController.text.isEmpty &&
                          _selectedCategoryEn == null)
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
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: medicines.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: sw * 0.025,
                                mainAxisSpacing: sw * 0.025,
                                childAspectRatio: _cardAspectRatio(sw),
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

            SizedBox(height: sh * 0.04),
          ],
        ),
      ),
    );
  }
}
