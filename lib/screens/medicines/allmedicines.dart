import 'package:flutter/material.dart';
import 'package:grad_project/models/medicine.dart';
import 'package:grad_project/screens/medicines/medicine_details.dart';
import 'package:grad_project/screens/searchscreen.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class Allmedicines extends StatefulWidget {
  const Allmedicines({super.key});

  @override
  State<Allmedicines> createState() => _AllmedicinesState();
}

class _AllmedicinesState extends State<Allmedicines> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String? selectedCategory;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Eczema', 'icon': Icons.healing},
    {'name': 'Nasal', 'icon': Icons.air},
    {'name': 'Fever', 'icon': Icons.thermostat},
    {'name': 'Infection', 'icon': Icons.coronavirus},
    {'name': 'Spasm', 'icon': Icons.electric_bolt},
    {'name': 'Pain', 'icon': Icons.medical_services},
  ];

  final List<Medicine> allMedicines = [
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
          'Liveasy Wellness Calcium Magnesium Vitamin D3 & Zinc is a daily dietary supplement designed to support strong bones, healthy teeth, muscle function, and immunity. It helps fill nutritional gaps and supports overall wellness, especially for people with low calcium or vitamin D intake.',
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

  List<Medicine> filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    filteredMedicines = allMedicines;
  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredMedicines = allMedicines.where((medicine) {
        final matchesQuery = medicine.name.toLowerCase().contains(
          query.toLowerCase(),
        );
        final matchesCategory =
            selectedCategory == null || medicine.category == selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void filterByCategory(String? category) {
    setState(() {
      selectedCategory = category;
      filteredMedicines = allMedicines.where((medicine) {
        return category == null || medicine.category == category;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Medicine",
          style: TextStyle(fontWeight: FontWeight.bold),
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
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: search,
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: const Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xff0D5FA7)),
                  ),
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),

          // Category chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory == category['name'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => filterByCategory(
                        isSelected ? null : category['name'],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: devwidth * 0.14,
                            height: devwidth * 0.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isSelected
                                  ? const Color(0xff2260FF)
                                  : const Color(0xffEEF2FF),
                            ),
                            child: Center(
                              child: Icon(
                                category['icon'] as IconData,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xff2260FF),
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category['name'],
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xff2260FF)
                                  : const Color(0xff33384B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Most Searched Medicines title
          if (!isSearching)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                "Most Searched Medicines",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          // Medicine grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = filteredMedicines[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScaffold(
                          currentIndex: 3,
                          child: MedicineDetails(medicine: medicine),
                        ),
                      ),
                    );
                  },
                  child: medicinecard(
                    name: medicine.name,
                    image: medicine.image,
                    description: medicine.description,
                    componant: medicine.component,
                    rate: medicine.rate,
                  ),
                );
              },
            ),
          ),

          // No results
          if (isSearching && filteredMedicines.isEmpty)
            Padding(
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
                  const Text(
                    "Sorry, no results found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Please try a different search term.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
