import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/medicine/medicinemodel.dart';
import 'package:grad_project/screens/prescriptions/reminder_screen.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class MedicineDetails extends StatefulWidget {
  final MedicineModel medicine;
  const MedicineDetails({super.key, required this.medicine});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String localized(BuildContext context, String en, String ar) {
      final lang = Localizations.localeOf(context).languageCode;
      return lang == 'ar' ? ar : en;
    }

    final medicine = widget.medicine;
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).medicineinfo,
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
            // ── Blue header card ─────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Blue section
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
                          localized(
                            context,
                            medicine.activeIngredientsEn,
                            medicine.activeIngredientsAr,
                          ),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          localized(context, medicine.usesEn, medicine.usesAr),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          localized(
                            context,
                            medicine.activeIngredientsEn,
                            medicine.activeIngredientsAr,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ✅ Only show sizes if list is not empty

                            // Medicine image
                            SizedBox(
                              height: devheight * 0.15,
                              width: devwidth * 0.3,
                              child: Image.asset(
                                medicine.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),

                            const Spacer(),

                            // Rating
                            Column(
                              children: [
                                Text(
                                  '4.5',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainScaffold(
                                currentIndex: 4,
                                child: ReminderScreen(
                                  medicineName: localized(
                                    context,
                                    medicine.brandNameEn,
                                    medicine.brandNameAr,
                                  ),
                                  medicineSize: '',
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
                        child: Text(
                          S.of(context).addreminder,
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

            // ── Product Overview ─────────────────────────────
            if (localized(context, medicine.usesEn, medicine.usesAr).isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).productoverview,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localized(context, medicine.usesEn, medicine.usesAr),
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

            if (localized(
              context,
              medicine.sideEffectsEn,
              medicine.sideEffectsAr,
            ).isNotEmpty)
              const Divider(height: 32, indent: 16, endIndent: 16),

            // ── Side Effects ─────────────────────────────────
            if (localized(
              context,
              medicine.sideEffectsEn,
              medicine.sideEffectsAr,
            ).isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).sideeffects,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              localized(
                                context,
                                medicine.sideEffectsEn,
                                medicine.sideEffectsAr,
                              ),
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
                  ],
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
