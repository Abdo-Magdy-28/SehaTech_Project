import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/signin.dart';
import 'package:grad_project/screens/signupform.dart';
import 'package:grad_project/widgets/carousel_card.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: devheight * 0.2),
            CarouselCard(
              title: 'Easily Consult Top Doctors Online & In-Person.',
              hint:
                  'Consult today. Find top doctors. Start your health journey with ease and confidence now!',
              image: 'assets/images/Card01-illu2.png',
            ),
            SizedBox(
              height: devheight * 0.6,
              width: devwidth * 0.88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SEHA TECH",
                    style: TextStyle(
                      fontSize: devwidth * 0.06,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'SEHA TECH helps you track, manage, and improve your\n'
                    'health with smart tools designed for every stage of life.',
                    style: TextStyle(
                      fontSize: devwidth * 0.025,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: devheight * 0.04),

                  /// Sign up With GOOGLE BUTTON
                  SizedBox(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff3f1f8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Icons2.svg"),
                          SizedBox(width: devwidth * 0.01),
                          Text(
                            "Sign Up With Google",
                            style: TextStyle(
                              color: Color(0xFF676767),
                              fontSize: devwidth * 0.045,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: devheight * 0.02),

                  /// Sign up With facebook Button
                  SizedBox(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0d61ec),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Icons.svg"),
                          SizedBox(width: devwidth * 0.01),
                          Text(
                            "Sign Up With Facebook",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: devwidth * 0.045,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// "Already Have An Account"
                  Padding(
                    padding: EdgeInsets.only(left: devwidth * 0.028),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Cairo',
                              fontSize: devwidth * 0.035,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Signin(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: devwidth * 0.035,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: devheight * 0.05),

                  /// Custom Gradient Slide Widget
                  GradientSlideToAct(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    text: "Swap To Create Account",
                    onSubmit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signupform()),
                      );
                    },
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

// Custom Gradient Slide Widget
class GradientSlideToAct extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onSubmit;

  const GradientSlideToAct({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<GradientSlideToAct> createState() => _GradientSlideToActState();
}

class _GradientSlideToActState extends State<GradientSlideToAct>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _isDragging = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animation =
        Tween<double>(begin: 0, end: 0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {
            _dragPosition = _animation.value;
          });
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateToPosition(double target) {
    _animation = Tween<double>(
      begin: _dragPosition,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    // حساب المساحات
    final padding = 12.0; // مسافة أكبر من الحواف
    final buttonDiameter = widget.height - 24; // الزرار أصغر
    final trackWidth = widget.width - (padding * 2); // عرض المسار
    final maxDrag = trackWidth - buttonDiameter; // أقصى مسافة للسحب
    final progress = maxDrag > 0
        ? (_dragPosition / maxDrag).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Stack(
        children: [
          // الخلفية المتحركة - بتملا كل المساحة
          Positioned.fill(
            child: AnimatedContainer(
              duration: _isDragging
                  ? Duration.zero
                  : Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: Color.lerp(Colors.white, Color(0xff90B8FF), progress),
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
          ),

          // النص - بيتحرك شمال شوية بسيطة
          AnimatedPositioned(
            duration: _isDragging ? Duration.zero : Duration(milliseconds: 400),
            left: -(_dragPosition * 0.15), // بيتحرك شمال شوية بس
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xff6B7280),
                  fontSize: widget.width * 0.04,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // الزرار المتحرك
          Positioned(
            left: padding + _dragPosition,
            top: padding,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _isDragging = true;
                  _dragPosition = (_dragPosition + details.delta.dx).clamp(
                    0.0,
                    maxDrag,
                  );
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  _isDragging = false;
                });

                if (_dragPosition >= maxDrag * 0.8) {
                  // مكتمل
                  _animateToPosition(maxDrag);
                  Future.delayed(Duration(milliseconds: 200), () {
                    widget.onSubmit();
                    Future.delayed(Duration(milliseconds: 100), () {
                      if (mounted) {
                        _animateToPosition(0);
                      }
                    });
                  });
                } else {
                  // رجوع للبداية
                  _animateToPosition(0);
                }
              },
              child: Container(
                width: buttonDiameter,
                height: buttonDiameter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xff2260FF),
                  size: buttonDiameter * 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
