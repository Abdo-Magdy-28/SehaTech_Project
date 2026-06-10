import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MedicationShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 90,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 120,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 10),
                  Container(height: 12, width: 80, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  Container(height: 12, width: 60, color: Colors.grey.shade300),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
