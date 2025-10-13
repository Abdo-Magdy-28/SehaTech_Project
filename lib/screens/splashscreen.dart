import 'package:flutter/material.dart';

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
  late final Animation<double> _moveAnimation;

  late final AnimationController _textController;

  @override
  void initState() {
    super.initState();

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

    _moveAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    // Text appear (fade + slide)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

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
    return Stack(
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
        Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _circleSizeAnimation,
              _curvedAnimation,
              _moveAnimation,
            ]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_moveAnimation.value, 0),
                child: Container(
                  width: _circleSizeAnimation.value,
                  height: _circleSizeAnimation.value,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
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
                      child: Image.asset(
                        'assets/images/Vector.png',
                        width: _circleSizeAnimation.value,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 350,
          right: 30,
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
                        begin: const Offset(-0.3, 0),
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
                  child: const Text(
                    "SehaTech",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
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
                  child: const Text(
                    "Health Comes First",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
