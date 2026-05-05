import 'package:flutter/material.dart';

class AllPrescriptions extends StatefulWidget {
  const AllPrescriptions({super.key});

  @override
  State<AllPrescriptions> createState() => _AllPrescriptionsState();
}

class _AllPrescriptionsState extends State<AllPrescriptions> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Prescriptions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
    );
  }
}
