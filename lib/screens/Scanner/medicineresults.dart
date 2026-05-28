import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Medicine%20Scan/medicinescan_cubit.dart';
import 'package:grad_project/cubit/Medicine%20Scan/medicinescan_states.dart';
import 'package:grad_project/models/medicine_preview_model.dart';

class MedicineResultScreen extends StatelessWidget {
  const MedicineResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: BlocBuilder<MedicineBoxCubit, MedicineBoxState>(
        builder: (context, state) {
          if (state is MedicineBoxLoading) {
            return const _LoadingView();
          }
          if (state is MedicineBoxFailure) {
            return _ErrorView(message: state.errorMessage);
          }
          if (state is MedicineBoxSuccess) {
            return _SuccessView(medicine: state.medicine);
          }
          return const Center(child: Text("No data yet"));
        },
      ),
    );
  }
}

// ─── Loading ───────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0c5adb), Color(0xFF0a4dbb), Color(0xFF083b8f)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              "Analyzing Medicine…",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Error ───────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFE53935),
              size: 56,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFE53935), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Success ───────────────────────────────────────────────
class _SuccessView extends StatelessWidget {
  final Medicine_preview medicine;
  const _SuccessView({required this.medicine});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            "assets/images/scan/bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: sh * 0.25,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    medicine.tradeName,
                    style: TextStyle(
                      fontSize: sw * 0.06,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0c5bdc),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoRow(label: "Trade Name", value: medicine.tradeName),
                  _InfoRow(label: "Generic Name", value: medicine.genericName),
                  _InfoRow(
                    label: "Concentration",
                    value: medicine.concentration,
                  ),
                  _InfoRow(label: "Manufacturer", value: medicine.manufacturer),
                  _InfoRow(label: "Dosage Form", value: medicine.dosageForm),
                  InfoListRow(
                    label: "Active Ingredients",
                    values: medicine.activeIngredients,
                  ),

                  _InfoRow(
                    label: "Indications",
                    value: medicine.indications.join(", "),
                  ),
                  _InfoRow(
                    label: "Contraindications",
                    value: medicine.contraindications.isEmpty
                        ? "None"
                        : medicine.contraindications.join(", "),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0c5bdc),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    child: const Text("Back To Scanning"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoListRow extends StatelessWidget {
  final String label;
  final List<String>? values;

  const InfoListRow({required this.label, this.values});

  @override
  Widget build(BuildContext context) {
    final items = values ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (items.isEmpty)
            const Text("null", style: TextStyle(color: Colors.black54))
          else
            ...items.map(
              (e) => Text(e, style: const TextStyle(color: Colors.black87)),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "null",
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
