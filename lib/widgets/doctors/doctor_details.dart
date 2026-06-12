import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/map.dart';
import 'package:url_launcher/url_launcher.dart';

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
    required this.urlprofile,
  });

  final String name, job, hospital, begindate, enddate, urlprofile;
  final double rate;
  final Image doctorimage;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  // ── LAUNCH PROFILE ──
  Future<void> _launchProfile() async {
    print('URL: ${widget.urlprofile}');
    final uri = Uri.parse(widget.urlprofile);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // ── IMAGE POPUP ──
  void _showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: widget.doctorimage, // ✅ Fixed: widget.doctorimage
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).doctorTitle(widget.name), // ✅ Fixed: widget.name
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${widget.job} | ${widget.hospital}", // ✅ Fixed: widget.job, widget.hospital
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Cairo',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    final scale = (devwidth / 360).clamp(0.85, 1.3);

    final double imageSize = 40 * scale;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── HERO SECTION ──
            SizedBox(
              height: devheight * 0.38,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Blue background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: BottomCurveClipper(),
                      child: Container(
                        height: devheight * 0.55,
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

                  // Doctor image — centered
                  Positioned(
                    top: -devheight * 0.09,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: Image.asset(
                          "assets/images/alldoctors/4c97a3a7-35a4-4cb5-91ae-47322cfa9eb4 1.png",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    // Name + doctor image icon
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
                          onTap: () => _showImagePopup(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: imageSize,
                              height: imageSize,
                              child: ClipOval(
                                child: widget
                                    .doctorimage, // ✅ Fixed: widget.doctorimage
                              ),
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

                    // Rating
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
                          onPressed: _launchProfile,
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
              child: Stack(
                children: [
                  const AppointmentPicker(),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).comingsoon,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── HELPERS (inside the State class) ──
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
  @override // ✅ Fixed: added missing @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - 80,
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

  // ── APPOINTMENT PICKER HELPERS (inside _AppointmentPickerState) ──

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
            Text(
              slots,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_left, size: 20),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ],
    );
  }
}
