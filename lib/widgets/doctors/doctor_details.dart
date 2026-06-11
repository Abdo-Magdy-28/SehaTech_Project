import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/map.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    super.key,
    required this.name,
    required this.begindate,
    required this.enddate,
    required this.hospital,
    required this.job,
    required this.rate,
    required this.doctorimage,
  });

  final String name, job, hospital, begindate, enddate;
  final double rate;
  final Image doctorimage;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── HERO SECTION ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Blue background with curve
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    height: devheight * 0.50,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/pharmacies/bg.png",
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/images/pharmacies/Mask group.png",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),

                // AppBar row
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: devwidth * 0.04,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        Text(
                          S.of(context).doctordetails,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                ),

                // Doctor image — centered, tall
                Positioned(
                  top: devheight * 0.252,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.scale(scale: 2, child: widget.doctorimage),
                  ),
                ),
              ],
            ),

            // ── INFO CARD ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: devwidth * 0.04),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + map icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
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
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Job | Hospital
                    Text(
                      "${widget.job} | ${widget.hospital}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Rating + timing
                    Row(
                      children: [
                        Text(
                          "${widget.rate}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset("assets/images/Star.png"),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset("assets/images/Time.png"),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${widget.begindate} - ${widget.enddate}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff33384B),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Stats row
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statItem("3yr", S.of(context).experience),
                          _divider(),
                          _statItem("50+", S.of(context).treated),
                          _divider(),
                          _statItem("350 L.E", S.of(context).hourlyrate),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Book button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1555D8), Color(0xFF2260FF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            S.of(context).bookappointment,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── APPOINTMENT PICKER ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: devwidth * 0.04),
              child: const AppointmentPicker(),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, color: Colors.black12, height: 40);
  }
}

// ── BOTTOM CURVE CLIPPER ──
class BottomCurveClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - 60,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ── APPOINTMENT PICKER ──
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
        _headerRow('Jan 2026', S.of(context).slots6),
        const SizedBox(height: 12),

        SizedBox(
          height: 76,
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

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerRow(S.of(context).availabletime, S.of(context).slots6),
              const SizedBox(height: 12),
              GridView.builder(
                padding: EdgeInsets.zero,
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
    width: 58,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: isSelected ? const Color(0xFFEEF3FF) : Colors.white,
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.grey.shade300,
        width: 1.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
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
        fontSize: 13,
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
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      Row(
        children: [
          Text(slots, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_left, size: 20),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    ],
  );
}
