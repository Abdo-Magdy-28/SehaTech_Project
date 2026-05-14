import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Prescription%20Scan/precriptionscan_cubit.dart';
import 'package:grad_project/cubit/Prescription%20Scan/prescriptionscan_states.dart';

class PrescriptionResultScreen extends StatelessWidget {
  const PrescriptionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: BlocBuilder<PrescriptionCubit, PrescriptionState>(
        builder: (context, state) {
          if (state is PrescriptionLoading) {
            return const _LoadingView();
          }
          if (state is PrescriptionError) {
            return _ErrorView(message: state.message);
          }
          if (state is PrescriptionSuccess) {
            return _SuccessView(data: state.data);
          }
          return const Center(child: Text("No data yet"));
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading
// ─────────────────────────────────────────────────────────────────────────────

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
              "Analyzing Prescription…",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error
// ─────────────────────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────────────────────
// Success
// ─────────────────────────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  final dynamic data;
  const _SuccessView({required this.data});

  @override
  Widget build(BuildContext context) {
    final List medications = data["medications"] ?? [];
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
          top: sh * 0.3,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(120)),
            ),

            child: Column(
              children: [
                SizedBox(height: sh * 0.12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RowCard(
                      sw: sw,
                      sh: sh,
                      label: "Doctor Name",
                      value: data["doctor_name"] ?? "Not Found",
                    ),

                    RowCard(
                      sw: sw,
                      sh: sh,
                      label: "Patient Name",
                      value: data["patient_name"] ?? "Not Found",
                    ),

                    RowCard(
                      sw: sw,
                      sh: sh,
                      label: "Date",
                      value: data["patient_date"] ?? "Not Found",
                    ),
                  ],
                ),

                SizedBox(height: sh * 0.02),
                Expanded(
                  child: Container(
                    width: sw * 0.95,
                    decoration: BoxDecoration(
                      color: Color(0xff0c5bdc),
                      borderRadius: BorderRadius.circular(24),
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: sh * 0.015),
                          Text(
                            "Medications",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sw * 0.05,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          SizedBox(height: sh * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color(0xff2cc55d),
                                size: sw * 0.035,
                              ),

                              SizedBox(width: sw * 0.015),

                              Text(
                                "${medications.length} Founded",
                                style: TextStyle(color: Color(0xffb3c4df)),
                              ),
                            ],
                          ),

                          SizedBox(height: sh * 0.02),

                          if (medications.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: sh * 0.02,
                              ),
                              child: Text(
                                "No medications found",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: sw * 0.04,
                                ),
                              ),
                            )
                          else
                            ...medications.asMap().entries.map(
                              (e) => PrescriptionCard(
                                sw: sw,
                                sh: sh,
                                medication: e.value,
                              ),
                            ),
                          SizedBox(height: sh * 0.02),
                          SizedBox(
                            width: sw * 0.8,
                            height: sh * 0.065,

                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.popUntil(context, (r) => r.isFirst),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                elevation: 0,

                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),

                              child: Text(
                                "Back To Scanning",
                                style: TextStyle(
                                  fontSize: sw * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: sh * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: sw * 0.075,
          child: SizedBox(
            width: sw * 0.8,
            height: sh * 0.5,
            child: Image.asset("assets/images/scan/Medicine-bro 1.png"),
          ),
        ),
        Positioned(
          top: sh * 0.05,
          left: sw * 0.035,

          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
      ],
    );
  }
}

class PrescriptionCard extends StatelessWidget {
  const PrescriptionCard({
    super.key,
    required this.sw,
    required this.sh,
    required this.medication,
  });

  final double sw;
  final double sh;
  final dynamic medication;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sw * 0.9,
      margin: EdgeInsets.only(bottom: sh * 0.015),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),

      child: Column(
        children: [
          SizedBox(height: sh * 0.02),
          Row(
            children: [
              SizedBox(width: sw * 0.05),
              Text(
                "Medication : ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${medication["name"]}",
                style: TextStyle(color: Colors.black87, fontSize: sw * 0.04),
              ),
            ],
          ),
          Text(
            "--------------------------------------------------",
            style: TextStyle(color: Color(0xffcecece)),
          ),
          Row(
            children: [
              SizedBox(width: sw * 0.05),
              Text(
                "Dosage : ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${medication["dosage"]}",
                style: TextStyle(color: Colors.black87, fontSize: sw * 0.04),
              ),
            ],
          ),
          Text(
            "--------------------------------------------------",
            style: TextStyle(color: Color(0xffcecece)),
          ),
          Row(
            children: [
              SizedBox(width: sw * 0.05),
              Text(
                "Frequency : ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${medication["frequency"]}",
                style: TextStyle(color: Colors.black87, fontSize: sw * 0.04),
              ),
            ],
          ),
          Text(
            "--------------------------------------------------",
            style: TextStyle(color: Color(0xffcecece)),
          ),
          Row(
            children: [
              SizedBox(width: sw * 0.05),
              Text(
                "Duration : ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: sw * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${medication["duration"]}",
                style: TextStyle(color: Colors.black87, fontSize: sw * 0.04),
              ),
            ],
          ),
          SizedBox(height: sh * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: sh * 0.15,
                height: sh * 0.005,
                decoration: BoxDecoration(
                  color: Color(0XFF0d61ec),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                child: Text(
                  "Notes",
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: sw * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                width: sh * 0.15,
                height: sh * 0.005,
                decoration: BoxDecoration(
                  color: Color(0XFF0d61ec),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          Text(
            "${medication["notes"]}",
            style: TextStyle(color: Color(0xff707070)),
          ),
          SizedBox(height: sh * 0.02),
        ],
      ),
    );
  }
}

class RowCard extends StatelessWidget {
  const RowCard({
    super.key,
    required this.sw,
    required this.sh,
    required this.label,
    required this.value,
  });

  final double sw;
  final double sh;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sw * 0.315,
      height: sh * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0c5adb), Color(0xFF0a4dbb), Color(0xFF083b8f)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: sw * 0.03,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: sh * 0.005),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffc0c8d5),
              fontSize: sw * 0.03,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
