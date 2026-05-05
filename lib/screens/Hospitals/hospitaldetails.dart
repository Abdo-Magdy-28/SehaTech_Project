import 'package:flutter/material.dart';
import 'package:grad_project/screens/map.dart';
import 'package:grad_project/widgets/pharmacies/ourservicescard.dart';

class Hospitaldetails extends StatefulWidget {
  const Hospitaldetails({
    super.key,
    required this.devheight,
    required this.rate,
    required this.name,
    required this.opentime,
    required this.closetime,
    required this.category,
  });
  final double devheight, rate;
  final String name;
  final String opentime;
  final String closetime, category;

  @override
  State<Hospitaldetails> createState() => _HospitaldetailsState();
}

class _HospitaldetailsState extends State<Hospitaldetails> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Hospital Information",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── TOP SECTION: background images + hospital card ───
            SizedBox(
              height: devheight * 0.52,
              child: Stack(
                children: [
                  // Background images
                  Image.asset(
                    "assets/images/pharmacies/bg.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image.asset("assets/images/pharmacies/Mask group.png"),

                  // Hospital info card
                  Positioned(
                    top: devheight * 0.18,
                    left: devwidth * 0.02,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: devheight * 0.3,
                        width: devwidth * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          color: const Color(0xffF6F6F6),
                        ),
                        child: Stack(
                          children: [
                            // Hospital name
                            Positioned(
                              top: devheight * 0.02,
                              left: devwidth * 0.035,
                              child: SizedBox(
                                width: 280,
                                child: Text(
                                  widget.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            // Subtitle: category
                            Positioned(
                              top: devheight * 0.065,
                              left: devwidth * 0.035,
                              child: SizedBox(
                                width: 280,
                                child: Text(
                                  widget.category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            // Map icon
                            Positioned(
                              top: devheight * 0.02,
                              right: devwidth * 0.035,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).push(
                                    MaterialPageRoute(
                                      builder: (_) => Mapscreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                    "assets/images/alldoctors/Frame2147226191.png",
                                  ),
                                ),
                              ),
                            ),

                            // Rating
                            Positioned(
                              top: devheight * 0.10,
                              left: devwidth * 0.05,
                              child: Row(
                                children: [
                                  Text(
                                    "${widget.rate}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    height: devheight * 0.02,
                                    width: devwidth * 0.05,
                                    child: Image.asset(
                                      "assets/images/Star.png",
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Experience
                            Positioned(
                              top: devheight * 0.15,
                              left: devwidth * 0.1,
                              child: Column(
                                children: [
                                  const Text(
                                    "3yr",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Experience",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 24/7 Work
                            Positioned(
                              top: devheight * 0.15,
                              left: devwidth * 0.42,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/Time.png",
                                        scale: devwidth * 0.009,
                                      ),
                                      const SizedBox(width: 2),
                                      const Text(
                                        "24/7",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Work",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Branches
                            Positioned(
                              top: devheight * 0.15,
                              left: devwidth * 0.65,
                              child: Column(
                                children: [
                                  const Text(
                                    "10",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Branches",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ✅ Contact Us button — properly centered
                            Positioned(
                              bottom: 7,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: SizedBox(
                                  width: 300,
                                  height: 56,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF1555D8),
                                          Color(0xFF2260FF),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Contact Us',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Our Services ───
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: devwidth * 0.05,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Our Services",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.9,
                    children: [
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Emergency Care',
                        subtitle: '24/7 emergency medical assistance.',
                      ),
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Outpatient',
                        subtitle: 'Consultations without admission needed.',
                      ),
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Surgery',
                        subtitle: 'Advanced surgical procedures available.',
                      ),
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Laboratory',
                        subtitle: 'Accurate and fast lab test results.',
                      ),
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Radiology',
                        subtitle: 'X-ray, MRI and CT scan services.',
                      ),
                      Ourservicescard(
                        image: 'assets/images/pharmacies/Frame 2147226268.png',
                        title: 'Physiotherapy',
                        subtitle: 'Rehabilitation and recovery programs.',
                      ),
                    ],
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
