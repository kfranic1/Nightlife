import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';
import 'package:nightlife/widgets/marker/concave_triangle.dart';

///
/// Custom GoogleMaps Marker
/// [height] is equal to [2.8 * radius]
///
class CustomMarker extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color color;

  const CustomMarker({super.key, required this.imageUrl, required this.radius, this.color = primaryColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: radius * 0.8),
          child: CircleAvatar(
            backgroundColor: color,
            radius: radius,
            child: CircleAvatar(
              radius: radius - 3,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ),
        ConcaveTriangle(
          radius: radius,
          color: color,
        ),
      ],
    );
  }
}
