import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/medicine.dart';
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
  bool _isSearching = false;
  String? _selectedCategory;

  late final List<Map<String, dynamic>> _categories = [
    {'name': S.of(context).eczema, 'icon': Icons.healing},
    {'name': S.of(context).nasal, 'icon': Icons.air},
    {'name': S.of(context).fever, 'icon': Icons.thermostat},
    {'name': S.of(context).infection, 'icon': Icons.coronavirus},
    {'name': S.of(context).spasm, 'icon': Icons.electric_bolt},
    {'name': S.of(context).pain, 'icon': Icons.medical_services},
  ];

  final List<Medicine> _allMedicines = [
    Medicine(
      name: 'Liveasy Wellness',
      image:
          'assets/images/search/liveasy-wellness-calcium-magnesium-vitamin-d3-zinc-bones-dental-health-bottle-60-tabs-6.1-1733485732.png',
      description: 'Calcium Magnesium Vitamin',
      component: 'D3 & Zinc',
      rate: 4.8,
      sizes: ['50gm', '100gm', 'Capsul', 'Syrup'],
      category: 'Eczema',
      overview:
          'Liveasy Wellness Calcium Magnesium Vitamin D3 & Zinc is a daily dietary supplement designed to support strong bones, healthy teeth, muscle function, and immunity.',
      keyBenefits: [
        'Supports bone strength and density',
        'Helps maintain healthy teeth',
        'Supports muscle function and reduces cramps',
        'Boosts immunity with Vitamin D3 and Zinc',
      ],
      sideEffects: [
        'Mild stomach upset',
        'Nausea',
        'Constipation or diarrhea',
        'Bloating',
      ],
    ),
    Medicine(
      name: 'Dr.Morepen',
      image:
          'assets/images/search/liveasy-wellness-calcium-magnesium-vitamin-d3-zinc-bones-dental-health-bottle-60-tabs-6.1-1733485732q3.png',
      description: 'Calcium Magnesium Vitamin',
      component: 'D3 & Zinc',
      rate: 4.8,
      sizes: ['50gm', '100gm', 'Capsul'],
      category: 'Fever',
      overview:
          'Dr.Morepen is a trusted health supplement supporting overall wellness with essential vitamins and minerals.',
      keyBenefits: [
        'Supports immune system',
        'Improves energy levels',
        'Maintains healthy metabolism',
      ],
      sideEffects: ['Mild nausea', 'Headache'],
    ),
    Medicine(
      name: 'Pharmeasy Optima',
      image: 'assets/images/search/lol.png',
      description: 'Calcium Magnesium Vitamin',
      component: 'D3 & Zinc',
      rate: 3.8,
      sizes: ['100gm', 'Syrup'],
      category: 'Nasal',
      overview:
          'Pharmeasy Optima is a nasal health supplement that helps relieve nasal congestion and supports respiratory health.',
      keyBenefits: [
        'Relieves nasal congestion',
        'Supports respiratory health',
        'Reduces inflammation',
      ],
      sideEffects: ['Dry mouth', 'Drowsiness'],
    ),
    Medicine(
      name: 'Juman Juice',
      image: 'assets/images/search/21.png',
      description: 'Calcium Magnesium Vitamin',
      component: 'D3 & Zinc',
      rate: 4.8,
      sizes: ['50gm', 'Syrup'],
      category: 'Pain',
      overview:
          'Juman Juice is a natural pain relief supplement made from organic ingredients to support pain management.',
      keyBenefits: [
        'Natural pain relief',
        'Reduces inflammation',
        'Supports joint health',
      ],
      sideEffects: ['Mild allergic reactions', 'Stomach discomfort'],
    ),
  ];

  List<Medicine> _filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    _filteredMedicines = _allMedicines;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredMedicines = _allMedicines.where((m) {
        final matchesQuery = m.name.toLowerCase().contains(query.toLowerCase());
        final matchesCategory =
            _selectedCategory == null || m.category == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String? category) {
    setState(() {
      _selectedCategory = category;
      _filteredMedicines = _allMedicines.where((m) {
        return category == null || m.category == category;
      }).toList();
    });
  }

  // horizontal padding = sw*0.03 each side = sw*0.06 total
  // gap between cards  = sw*0.025
  // cardW = (sw - sw*0.06 - sw*0.025) / 2
  //
  // card height sections (mirrors medicinecard.dart exactly):
  //   image SizedBox : cardW * 0.65
  //   name row       : sw * 0.033 * 1.5  ≈ sw * 0.050
  //   gap            : sw * 0.008
  //   description    : sw * 0.026 * 1.5  ≈ sw * 0.039
  //   gap            : sw * 0.005
  //   component      : sw * 0.026 * 1.5  ≈ sw * 0.039
  //   view btn       : sw * 0.025*2 + sw*0.034*1.5 ≈ sw * 0.101
  //   extra buffer   : sw * 0.04   (spacer + rounding safety)
  double _cardAspectRatio(double sw) {
    final cardW = (sw - sw * 0.06 - sw * 0.025) / 2;
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

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
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
          // ── Search bar ─────────────────────────────────────────────
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
                onChanged: _search,
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

          // ── Category chips ─────────────────────────────────────────
          SizedBox(
            height: sw * 0.22,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => SizedBox(width: sw * 0.025),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final sel = _selectedCategory == cat['name'];
                return GestureDetector(
                  onTap: () => _filterByCategory(sel ? null : cat['name']),
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
                            color: sel ? Colors.white : const Color(0xff2260FF),
                            size: sw * 0.065,
                          ),
                        ),
                      ),
                      SizedBox(height: sw * 0.015),
                      Text(
                        cat['name'],
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

          // ── Section title ──────────────────────────────────────────
          if (!_isSearching)
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

          // ── 2-column Medicine Grid ─────────────────────────────────
          if (_filteredMedicines.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredMedicines.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: sw * 0.025,
                  mainAxisSpacing: sw * 0.025,
                  childAspectRatio: _cardAspectRatio(sw),
                ),
                itemBuilder: (_, i) {
                  final med = _filteredMedicines[i];
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

          // ── Empty state ────────────────────────────────────────────
          if (_isSearching && _filteredMedicines.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: sh * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sw * 0.12,
                    width: sw * 0.12,
                    child: Image.asset('assets/images/alldoctors/search.png'),
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
            ),

          SizedBox(height: sh * 0.04),
        ],
      ),
    );
  }
}
