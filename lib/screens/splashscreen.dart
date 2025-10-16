// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/screens/loginpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curvedAnimation;

  late final AnimationController _circleController;
  late final Animation<double> _circleSizeAnimation;

  late final AnimationController _moveController;
  late Animation<double> _moveAnimation; // ✅ Changed to non-final

  late final AnimationController _textController;

  bool _isInitialized = false; // ✅ Added flag

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Loginpage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
    // First animation (shader slide)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    // Second animation (circle shrink)
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _circleSizeAnimation = Tween<double>(begin: 150, end: 90).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutCubic),
    );

    // Third animation (move left)
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // ✅ Initialize with placeholder value
    _moveAnimation =
        Tween<double>(
          begin: 0,
          end: 0, // Will be updated in didChangeDependencies
        ).animate(
          CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
        );

    // Text appear (fade + slide)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  // ✅ Override didChangeDependencies to access MediaQuery safely
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;

      // ✅ Now safe to use MediaQuery
      _moveAnimation =
          Tween<double>(
            begin: 0,
            end: -MediaQuery.of(context).size.width * 0.25,
          ).animate(
            CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
          );

      // ✅ Start animation chain here
      _controller.forward();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) _circleController.forward();
      });
      _circleController.addStatusListener((status) {
        if (status == AnimationStatus.completed) _moveController.forward();
      });
      _moveController.addStatusListener((status) {
        if (status == AnimationStatus.forward) _textController.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _circleController.dispose();
    _moveController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen size for responsiveness
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // Responsive scaling
    final baseCircleSize = width * 0.35;
    final minCircleSize = width * 0.22;
    final textRightPadding = width * 0.15;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🌈 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF215DF7), Color(0xFF0C1F51)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🎯 Animated circle + vector
          AnimatedBuilder(
            animation: Listenable.merge([
              _circleSizeAnimation,
              _curvedAnimation,
              _moveAnimation,
            ]),
            builder: (context, child) {
              final circleSize = Tween<double>(
                begin: baseCircleSize,
                end: minCircleSize,
              ).evaluate(_circleController);

              return Transform.translate(
                offset: Offset(_moveAnimation.value, 0),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circleSize / 2),
                    color: Colors.white,
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [
                          _curvedAnimation.value,
                          (_curvedAnimation.value + 0.1).clamp(0.0, 1.0),
                        ],
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/Vector.svg',
                        width: circleSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // 🧠 Text Animation
          Positioned(
            right: textRightPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: _textController,
                      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
                    ),
                  ),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(-0.4, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _textController,
                            curve: const Interval(
                              0.0,
                              0.5,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: Text(
                      "SEHA TECH",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.095,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1.2,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),

                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: _textController,
                      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
                    ),
                  ),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(-0.3, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _textController,
                            curve: const Interval(
                              0.5,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: Text(
                      " Health Comes First",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.045,
                        fontFamily: 'PoltawskiNowy',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
