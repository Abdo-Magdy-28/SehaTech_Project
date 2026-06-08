import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/main.dart';
import 'package:grad_project/screens/Scanner/MedicineScanner.dart';
import 'package:grad_project/screens/Scanner/PrescriptionScannerscreen.dart';

class Scanscreen extends StatefulWidget {
  const Scanscreen({super.key});

  @override
  State<Scanscreen> createState() => _ScanscreenState();
}

class _ScanscreenState extends State<Scanscreen> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,

          title: Text(
            "Scanning",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              color: Color(0xff111111),
              fontSize: 20,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: devwidth, child: const Divider(thickness: 1)),
              SizedBox(height: devheight * 0.03),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Container(
                      width: devwidth * 0.89,
                      height: devheight * 0.25,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.8),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Color(0xFF143A99), Color(0xff2260FF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border.all(
                          color: Color(0xffc9c9c9),
                          width: 0.5,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/Mask group.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: devwidth * 0.08,
                    top: devheight * 0.02,
                    child: Text(
                      "Scan Prescriptions and Medications \nInstantly to Access Accurate Details,\n Dosage Instructions, and Safety\n Information",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: devwidth * 0.03,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    top: devheight * 0.048,
                    left: devwidth * 0.575,
                    child: Image.asset(
                      'assets/images/scan/Hand.png',
                      height: devheight * 0.2,
                      width: devwidth * 0.4,
                    ),
                  ),
                  Positioned(
                    top: devheight * 0.04,
                    left: devwidth * 0.6,
                    child: Image.asset(
                      'assets/images/scan/Frame 2147226235.png',
                      height: devheight * 0.2,
                      width: 130,
                    ),
                  ),
                  Positioned(
                    left: devwidth * 0.08,
                    top: devheight * 0.11,
                    child: Text(
                      "Easily scan any prescription or medicine QR code\n to view complete information, including usage\n guidelines, warnings, interactions, and important\n notes — all in one place, in seconds.",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: devwidth * 0.025,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: devheight * 0.04),
              Text(
                S.of(context).quickScan,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: devheight * 0.02),
              Text(
                'Point your camera at the QR code and get the full\n medication profile in seconds.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff808080),
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: devheight * 0.08),
              SizedBox(
                height: 50,
                width: 325,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0d61ec),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (cameras.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Medicinescanner(camera: cameras.first),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/scan/mdi_line-scan.svg'),
                      SizedBox(width: devwidth * 0.04),
                      Text(
                        "Scan the Medicine",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: devheight * 0.02),
              SizedBox(
                height: 50,
                width: 325,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (cameras.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Prescriptionscannerscreen(camera: cameras.first),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/scan/scanpaper.svg'),
                      SizedBox(width: devwidth * 0.04),
                      Text(
                        "Scan prescription.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
