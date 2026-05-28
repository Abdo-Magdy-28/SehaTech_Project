import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Medicine%20Scan/medicinescan_cubit.dart';
import 'package:grad_project/cubit/Prescription%20Scan/precriptionscan_cubit.dart';
import 'package:grad_project/screens/Scanner/Prescriptionresults.dart';
import 'package:grad_project/screens/Scanner/medicineresults.dart';
import 'package:grad_project/services/medicinescan_service.dart';

class MedicinePreviewScreen extends StatelessWidget {
  final File imageFile;

  const MedicinePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: Image.file(imageFile))),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Retake"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Start the analysis
                        context.read<MedicineBoxCubit>().analyzeImage(
                          imageFile,
                        );

                        // Navigate and reuse the SAME cubit
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<MedicineBoxCubit>(),
                                child: const MedicineResultScreen(),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text("Use Photo"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
