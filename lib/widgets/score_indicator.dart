import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/double_extension.dart';

class ScoreIndicator extends StatelessWidget {
  final double score;
  final double scale;

  const ScoreIndicator({super.key, required this.score, this.scale = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: scale,
      child: Stack(
        children: [
          CustomPaint(
            painter: ScoreCirclePainter(
              score.color,
              score / 10,
              strokeWidth: scale / 50 * 10,
            ),
            child: Container(),
          ),
          Center(
            child: Text(
              score.toStringAsFixed(1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14 * scale / 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreCirclePainter extends CustomPainter {
  final Color color;
  final Color backgroundColor;
  final double percentage;
  final double strokeWidth;

  ScoreCirclePainter(this.color, this.percentage, {this.strokeWidth = 10, this.backgroundColor = const Color.fromARGB(0, 255, 255, 255)});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    Paint foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      -math.pi * 2 * percentage,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
