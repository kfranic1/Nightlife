import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class ClubImage extends StatelessWidget {
  const ClubImage({super.key});

  @override
  Widget build(BuildContext context) {
    final Club club = context.watch<Club>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: Seo.image(
          alt: "Nightlife Zagreb - ${club.name}",
          src: club.imageUrl,
          child: Image.network(
            club.imageUrl,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
