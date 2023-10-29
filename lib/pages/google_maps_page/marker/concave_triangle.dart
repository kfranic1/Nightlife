import 'package:flutter/material.dart';

class ConcaveTriangle extends StatelessWidget {
  const ConcaveTriangle({super.key, required this.radius, required this.color});

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ConcaveTrianglePainter(color: color),
      size: Size(radius, radius * 0.866),
    );
  }
}

class _ConcaveTrianglePainter extends CustomPainter {
  final Color color;

  _ConcaveTrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path()
      ..moveTo(width / 2, height) // bottom center
      ..lineTo(width, 0) // top right
      ..quadraticBezierTo(width / 2, height * 0.3, 0, 0) // concave curve
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
