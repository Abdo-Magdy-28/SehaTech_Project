import 'package:flutter/material.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/widgets/pharmacies/pharmacy_card.dart';

class Allpahramcies extends StatefulWidget {
  const Allpahramcies({super.key});

  @override
  State<Allpahramcies> createState() => _AllpahramciesState();
}

class _AllpahramciesState extends State<Allpahramcies> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String? selectedCategory;
  List<Pharmacy> categoryPharmacies = [];
  List<Pharmacy> filteredPharmacies = [];
  List<Pharmacy> allPharmacies = [
    Pharmacy(name: "Elazaby", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
    Pharmacy(name: "Al_amwy", rating: 4.5, is24Hours: true),
  ];
  String currentoption = '';

  void sortname() {
    setState(() {
      filteredPharmacies.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortrate() {
    setState(() {
      filteredPharmacies.sort((a, b) => b.rating.compareTo(a.rating));
    });
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
                currentoption = 'location';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location: nearest first",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'location')
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
            onTap: () {
              setModalState(() {
                currentoption = 'rating';
              });
              sortrate();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rating: The Best First",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'rating')
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
            onTap: () {
              setModalState(() {
                currentoption = 'price';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: From Low To Hight",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'price')
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
            onTap: () {
              setModalState(() {
                currentoption = 'name';
              });
              sortname();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Alphabet: From A>Z", style: TextStyle(fontSize: 16)),
                  if (currentoption == 'name')
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
            onTap: () {
              setModalState(() {
                currentoption = 'experience';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience: More Experience First",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (currentoption == 'experience')
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
              child: const Text(
                'Save',
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
  void initState() {
    super.initState();
    filteredPharmacies = allPharmacies;
  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredPharmacies = allPharmacies.where((Pharmacy) {
        return Pharmacy.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
          "Pharmacies",
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
                onChanged: search,
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: Color(0xff0D5FA7),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff0D5FA7)),
                  ),
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
          // After the search bar padding, before the "Popular Pharmacies" text
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
                    currentoption == '' || currentoption == 'location'
                        ? "By Location"
                        : currentoption == 'rating'
                        ? "By Rating"
                        : currentoption == 'price'
                        ? "By Price"
                        : currentoption == 'name'
                        ? "Alphabetically"
                        : currentoption == 'experience'
                        ? "By Experience"
                        : "By Location",
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
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Popular Pharmacies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredPharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = filteredPharmacies[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: PharmacyCard(
                    devheight: devheight,
                    name: pharmacy.name,
                    rate: pharmacy.rating,
                    isopen24: pharmacy.is24Hours,
                  ),
                ),
              );
            },
          ),
          if (isSearching && filteredPharmacies.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset('assets/images/alldoctors/search.png'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Sorry, no results found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Please try a different search term.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
