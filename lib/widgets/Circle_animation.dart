import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curvedAnimation;

  late final AnimationController _circleController;
  late final Animation<double> _circleSizeAnimation;

  late final AnimationController moveController;
  late final Animation<double> _moveAnimation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _circleSizeAnimation = Tween<double>(begin: 150, end: 90).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutCubic),
    );

    moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _moveAnimation = Tween<double>(
      begin: 0,
      end: -100,
    ).animate(CurvedAnimation(parent: moveController, curve: Curves.easeInOut));
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _circleController.forward();
    });

    _circleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) moveController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _circleController.dispose();
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _circleSizeAnimation,
          _curvedAnimation,
          _moveAnimation,
          // _textOpacity,
          // _textSlide,
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
                    width:
                        _circleSizeAnimation.value, // 👈 scales with container
                    fit: BoxFit.contain, // 👈 keeps full image visible
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
