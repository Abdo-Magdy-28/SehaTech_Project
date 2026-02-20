import 'package:flutter/material.dart';
import 'package:grad_project/screens/map.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({
    super.key,
    required this.name,
    required this.begindate,
    required this.enddate,
    required this.hospital,
    required this.job,
    required this.rate,
  });
  String name, job, hospital, begindate, enddate;
  double rate;
  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
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
          "Doctor Details",
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
              Container(color: Colors.white, height: devheight),
              ClipPath(
                clipper: CustomClipPath(),
                child: Image.asset("assets/images/alldoctors/bg.png"),
              ),
              Positioned(
                top: devheight * 0.5,
                left: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffF6F6F6),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          left: 15,
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
                          top: 55,
                          left: 15,
                          child: SizedBox(
                            width: 280,
                            child: Text(
                              "${widget.job} | ${widget.hospital}",
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
                          top: 15,
                          right: 15,
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
                          top: 85,
                          left: 15,
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
                                height: 20,
                                width: 20,
                                child: Image.asset("assets/images/Star.png"),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 85,
                          left: 70,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset("assets/images/Time.png"),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${widget.begindate} - ${widget.enddate}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff33384B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 110,
                          left: 40,
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
                          top: 110,
                          left: 140,
                          child: Column(
                            children: [
                              Text(
                                "50+",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Treated",
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
                          top: 110,
                          left: 220,
                          child: Column(
                            children: [
                              Text(
                                "350 L.E",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Hourly Rate",
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
                          left: 15,
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
                                  'Book Appointment',
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
                top: devheight * 0.5 + 260, // 👈 below the card
                left: 16,
                right: 16,
                child: AppointmentPicker(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentPicker extends StatefulWidget {
  const AppointmentPicker({super.key});

  @override
  State<AppointmentPicker> createState() => _AppointmentPickerState();
}

class _AppointmentPickerState extends State<AppointmentPicker> {
  int selectedDateIndex = 3;
  int selectedTimeIndex = 1;

  final dates = [
    {'day': 'Sun', 'date': '21'},
    {'day': 'Mon', 'date': '22'},
    {'day': 'Tue', 'date': '23'},
    {'day': 'Thu', 'date': '24'},
    {'day': 'Wed', 'date': '25'},
    {'day': 'Fri', 'date': '26'},
  ];

  final times = [
    '12:30 PM',
    '12:45 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// DATE HEADER
        _headerRow('Jan2024', '6 slots'),

        const SizedBox(height: 12),

        /// DATE LIST
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = index == selectedDateIndex;
              return GestureDetector(
                onTap: () => setState(() => selectedDateIndex = index),
                child: _dateItem(
                  dates[index]['day']!,
                  dates[index]['date']!,
                  isSelected,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        /// AVAILABLE TIME
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12, // 👈 reduced
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerRow('Available time', '6 slots'),

              const SizedBox(height: 8), // 👈 reduced from 12

              GridView.builder(
                padding: EdgeInsets.zero, // 👈 ADD THIS

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: times.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final isSelected = index == selectedTimeIndex;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTimeIndex = index),
                    child: _timeItem(times[index], isSelected),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _dateItem(String day, String date, bool isSelected) {
  return Container(
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.grey,
        width: 1.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget _timeItem(String time, bool isSelected) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.grey.shade300,
      ),
    ),
    child: Text(
      time,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _headerRow(String title, String slots) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      Row(
        children: [
          Text(slots, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_left, size: 20),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    ],
  );
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 150, w, h);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
