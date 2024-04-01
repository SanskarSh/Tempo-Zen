import 'package:flutter/material.dart';

class TVLines extends StatelessWidget {
  final double lineThickness;
  final double lineSpacing;
  final Color lineColor;

  const TVLines({
    Key? key,
    this.lineThickness = 1.0,
    this.lineSpacing = 5.0,
    this.lineColor = Colors.black38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TVLinesPainter(
        lineThickness: lineThickness,
        lineSpacing: lineSpacing,
        lineColor: lineColor,
      ),
    );
  }
}

class TVLinesPainter extends CustomPainter {
  final double lineThickness;
  final double lineSpacing;
  final Color lineColor;

  TVLinesPainter({
    required this.lineThickness,
    required this.lineSpacing,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineThickness;

    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(TVLinesPainter oldDelegate) =>
      lineThickness != oldDelegate.lineThickness ||
      lineSpacing != oldDelegate.lineSpacing ||
      lineColor != oldDelegate.lineColor;
}
