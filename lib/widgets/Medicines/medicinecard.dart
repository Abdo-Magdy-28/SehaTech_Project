import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/medicine.dart';
import 'package:grad_project/screens/medicines/medicine_details.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});

  final Medicine medicine;

  // safe: never called with an empty-sizes Medicine again,
  // but guard here as last resort
  Medicine _safe(BuildContext context, Medicine m) => Medicine(
    name: m.name,
    image: m.image,
    description: m.description,
    component: m.component,
    rate: m.rate,
    category: m.category,
    overview: m.overview,
    keyBenefits: m.keyBenefits,
    sideEffects: m.sideEffects,
    sizes: m.sizes.isNotEmpty ? m.sizes : [(S.of(context).capsule)],
  );

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MainScaffold(
          currentIndex: 3,
          child: MedicineDetails(medicine: _safe(context, medicine)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final cardW = (sw - sw * 0.06 - sw * 0.025) / 2;

    return GestureDetector(
      onTap: () => _navigate(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(sw * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────
            SizedBox(
              height: cardW * 0.65,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(cardW * 0.06),
                  child: Image.asset(medicine.image, fit: BoxFit.contain),
                ),
              ),
            ),

            // ── Name + Rating ───────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cardW * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      medicine.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: sw * 0.03,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${medicine.rate}',
                        style: TextStyle(fontSize: sw * 0.028),
                      ),
                      SizedBox(width: sw * 0.004),
                      Image.asset(
                        'assets/images/Star.png',
                        height: sw * 0.035,
                        width: sw * 0.035,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: sw * 0.008),

            // ── Description ─────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cardW * 0.1),
              child: Text(
                medicine.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: sw * 0.026,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),

            SizedBox(height: sw * 0.005),

            // ── Component ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cardW * 0.1),
              child: Text(
                medicine.component,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: sw * 0.026,
                  color: Colors.black.withOpacity(0.45),
                ),
              ),
            ),

            const Spacer(),

            // ── View button ─────────────────────────────────────
            GestureDetector(
              onTap: () => _navigate(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: sw * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xff0D61EC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(sw * 0.03),
                    bottomRight: Radius.circular(sw * 0.03),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).view,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sw * 0.034,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
