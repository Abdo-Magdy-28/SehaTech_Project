import 'package:flutter/material.dart';

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
    final padding = 12.0;
    final buttonDiameter = widget.height - 24;
    final trackWidth = widget.width - (padding * 2);
    final maxDrag = trackWidth - buttonDiameter;
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

          AnimatedPositioned(
            duration: _isDragging ? Duration.zero : Duration(milliseconds: 400),
            left: -(_dragPosition * 0.15),
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
                  // Back to start
                  _animateToPosition(0);
                }
              },
              child: Container(
                width: buttonDiameter,
                height: buttonDiameter,
                decoration: BoxDecoration(
                  color: Color.lerp(Color(0xff2260FF), Colors.white, progress),
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
                  color: Color.lerp(Colors.white, Color(0xff003D99), progress),
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
