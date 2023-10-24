import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 12, 54, 82),
                Color.fromARGB(255, 19, 16, 45),
                Color.fromARGB(255, 19, 16, 45),
                Color.fromARGB(255, 52, 15, 68),
              ],
              stops: [0.0, 0.2, 0.8, 1.0],
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
