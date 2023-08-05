import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

extension DoubleExtension on double {
  Color get color {
    if (this <= 0 || this > 10) return primaryColor;
    if (this <= 5) return Color.lerp(Colors.red, Colors.yellow, this / 5)!;
    return Color.lerp(Colors.yellow, Colors.green, (this - 5) / 5)!;
  }
}
