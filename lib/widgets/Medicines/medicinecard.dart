import 'package:flutter/material.dart';
import 'package:grad_project/models/medicine.dart';
import 'package:grad_project/screens/medicines/medicine_details.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.componant,
    required this.rate,
  });

  final String name, image, description, componant;
  final double rate;

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;
    Medicine medicine = Medicine(
      name: name,
      image: image,
      description: description,
      component: componant,
      rate: rate,
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
    );
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      height: devheight * 0.28,
      width: devwidth * 0.458,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: devheight * 0.1,
                width: devheight * 0.1,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
          // Name & Rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("$rate", style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 2),
                    Image.asset(
                      "assets/images/Star.png",
                      height: devheight * 0.035,
                      width: devwidth * 0.035,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Component
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              componant,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
          const Spacer(),
          // Button
          GestureDetector(
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
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff0D61EC),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: devwidth * 0.8,
              height: devheight * 0.05,
              child: Center(
                child: Text(
                  "View",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
