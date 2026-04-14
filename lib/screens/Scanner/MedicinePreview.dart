import 'dart:io';
import 'package:flutter/material.dart';

class Medicinepreview extends StatelessWidget {
  final File imageFile;

  const Medicinepreview({super.key, required this.imageFile});

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
                        //  SEND TO YOUR PRESCRIPTION MODEL HERE
                        print("Send: ${imageFile.path}");

                        Navigator.pop(context);
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
