import 'package:flutter/material.dart';

extension DoubleExtension on double {
  Color get color {
    if (this <= 0 || this > 10) return Colors.white;
    if (this <= 5) return Color.lerp(Colors.red, Colors.yellow, this / 5)!;
    return Color.lerp(Colors.yellow, Colors.green, (this - 5) / 5)!;
  }
}
