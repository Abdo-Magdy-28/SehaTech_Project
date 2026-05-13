import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Prescription%20Scan/precriptionscan_cubit.dart';
import 'package:grad_project/screens/Scanner/Prescriptionresults.dart';

class PrescriptionPreviewScreen extends StatelessWidget {
  final File imageFile;

  const PrescriptionPreviewScreen({super.key, required this.imageFile});

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
                        context.read<PrescriptionCubit>().analyzePrescription(
                          imageFile,
                        );

                        // Navigate and reuse the SAME cubit
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<PrescriptionCubit>(),
                                child: const PrescriptionResultScreen(),
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
