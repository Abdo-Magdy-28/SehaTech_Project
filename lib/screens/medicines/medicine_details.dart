import 'package:flutter/material.dart';
import 'package:grad_project/models/medicine.dart';
import 'package:grad_project/screens/prescriptions/reminder_screen.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class MedicineDetails extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetails({super.key, required this.medicine});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.medicine.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return (Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blue header card
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Blue top section
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff2260FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          medicine.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          medicine.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          medicine.component,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Medicine image + sizes + rating row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Size chips
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: medicine.sizes.map((size) {
                                final isSelected = selectedSize == size;
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedSize = size),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Cairo',
                                        color: isSelected
                                            ? const Color(0xff2260FF)
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const Spacer(),
                            // Medicine image
                            SizedBox(
                              height: devheight * 0.15,
                              width: devwidth * 0.3,
                              child: Image.asset(
                                medicine.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Spacer(),
                            // Rating
                            Column(
                              children: [
                                Text(
                                  "${medicine.rate}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < medicine.rate.floor()
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Colors.amber,
                                      size: 16,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Add Reminder button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScaffold(
                                currentIndex: 4,
                                child: ReminderScreen(
                                  medicineName: medicine.name,
                                  medicineSize:
                                      selectedSize ?? medicine.sizes.first,
                                ),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2260FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Add Reminder",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "product Overview",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medicine.overview,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Cairo',
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 32, indent: 16, endIndent: 16),

            // Key Benefits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Key Benefits",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...medicine.keyBenefits.map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 32, indent: 16, endIndent: 16),

            // Possible Side Effects
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Possible Side Effects",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...medicine.sideEffects.map(
                    (effect) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              effect,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}
