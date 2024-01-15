import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCircularIndicator extends StatefulWidget {
  final double radius;
  final Color color;
  final Duration duration;

  const CustomCircularIndicator({super.key, 
    this.radius = 20.0,
    this.color = Colors.blue,
    this.duration = const Duration(seconds: 1),
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomCircularIndicatorState createState() => _CustomCircularIndicatorState();
}

class _CustomCircularIndicatorState extends State<CustomCircularIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _animation = Tween(begin: 0.0, end: 2 * math.pi).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CustomCircularPainter(
              angle: _animation.value,
              color: widget.color,
            ),
            size: Size(widget.radius * 2, widget.radius * 2),
          );
        },
      ),

      
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomCircularPainter extends CustomPainter {
  final double angle;
  final Color color;

  CustomCircularPainter({required this.angle, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
