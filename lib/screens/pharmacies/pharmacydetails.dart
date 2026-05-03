import 'package:flutter/material.dart';
import 'package:grad_project/screens/map.dart';
import 'package:grad_project/widgets/pharmacies/ourservicescard.dart';

class PharmacyDetails extends StatefulWidget {
  const PharmacyDetails({
    super.key,
    required this.devheight,
    required this.rate,
    required this.name,
    required this.isopen24,
  });
  final double devheight, rate;
  final String name;
  final bool isopen24;
  @override
  State<PharmacyDetails> createState() => _PharmacydetailsState();
}

class _PharmacydetailsState extends State<PharmacyDetails> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pharmacy Information",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 950,
          child: Stack(
            children: [
              Image.asset("assets/images/pharmacies/bg.png"),
              Image.asset("assets/images/pharmacies/Mask group.png"),
              Positioned(
                top: devheight * 0.14,
                left: devwidth * 0.02,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Color(0xffF6F6F6),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: devheight * 0.02,
                          left: devwidth * 0.035,
                          child: SizedBox(
                            width: 280,
                            child: Text(
                              widget.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: devheight * 0.065,
                          left: devwidth * 0.035,
                          child: SizedBox(
                            width: 280,
                            child: Text(
                              "Pharmacy",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: devheight * 0.02,
                          right: devwidth * 0.035,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(builder: (_) => Mapscreen()),
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
                        Positioned(
                          top: devheight * 0.10,
                          left: devwidth * 0.05,
                          child: Row(
                            children: [
                              Text(
                                "${widget.rate}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                height: devheight * 0.02,
                                width: devwidth * 0.05,
                                child: Image.asset("assets/images/Star.png"),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: devheight * 0.1,
                          left: devwidth * 0.25,
                          child: Text(
                            "Delivering 10:30am - 1:00am",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff33384B),
                            ),
                          ),
                        ),
                        Positioned(
                          top: devheight * 0.15,
                          left: devwidth * 0.1,
                          child: Column(
                            children: [
                              Text(
                                "3yr",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
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
                                  SizedBox(width: 2),
                                  Text(
                                    "24/7",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
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
                        Positioned(
                          top: devheight * 0.15,
                          left: devwidth * 0.65,
                          child: Column(
                            children: [
                              Text(
                                "10",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
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

                        Positioned(
                          bottom: 10,
                          left: devwidth * 0.1,
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
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: devheight * 0.5,
                left: devwidth * 0.05,
                child: SizedBox(
                  width: 280,
                  child: Text(
                    "Our Services",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Positioned(
                top: devheight * 0.55,
                left: devwidth * 0.05,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),
              Positioned(
                top: devheight * 0.55,
                left: devwidth * 0.52,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),
              Positioned(
                top: devheight * 0.68,
                left: devwidth * 0.05,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),
              Positioned(
                top: devheight * 0.68,
                left: devwidth * 0.52,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),

              Positioned(
                top: devheight * 0.81,
                left: devwidth * 0.05,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),
              Positioned(
                top: devheight * 0.81,
                left: devwidth * 0.52,
                child: Ourservicescard(
                  image: 'assets/images/pharmacies/Frame 2147226268.png',
                  title: 'Home Delivery',
                  subtitle: 'Get your order delivered to your doorstep.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
