import 'package:flutter/material.dart';
import 'dart:math';

class GradientCircularIndicator extends StatefulWidget {
  GradientCircularIndicator(
      {required this.size,
      this.secondaryColor = Colors.white,
      this.primaryColor = Colors.orange,
      this.lapDuration = 1000,
      this.strokeWidth = 5.0}); // 2
  final double size;
  final Color secondaryColor;
  final Color primaryColor;
  final int lapDuration;
  final double strokeWidth;

  @override
  _GradientCircularIndicator createState() => new _GradientCircularIndicator();
} // 3

class _GradientCircularIndicator extends State<GradientCircularIndicator> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  
  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.lapDuration))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
    turns: Tween(begin: 0.0, end: 1.0,).animate(controller),
    child: CustomPaint(
      painter: CirclePaint(secondaryColor: widget.secondaryColor, primaryColor: widget.primaryColor, strokeWidth: widget.strokeWidth),
      size: Size(widget.size, widget.size),
    ),
  );
  }
}
// progress: animation.value
class CirclePaint extends CustomPainter {
  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;

  // 2
  double _degreeToRad(double degree) => degree * pi / 180;

  CirclePaint(
      {this.secondaryColor = Colors.grey,
      this.primaryColor = Colors.blue,
      this.strokeWidth = 15});

  @override
  void paint(Canvas canvas, Size size) {
    double centerPoint = size.height / 2;

    Paint paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.shader = SweepGradient(
      colors: [secondaryColor, primaryColor],
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(270),
      endAngle: _degreeToRad(270 + 360.0),
    ).createShader(Rect.fromCircle(
        center: Offset(centerPoint, centerPoint), radius: 0)); // 1
    var scapSize = strokeWidth * 0.70;
    double scapToDegree = scapSize / centerPoint; // 2
    double startAngle = _degreeToRad(270) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(Offset(0.0, 0.0) & Size(size.width, size.width), startAngle,
        sweepAngle, false, paint..color = primaryColor);
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }
}
