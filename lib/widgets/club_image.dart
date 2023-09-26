import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/score_indicator.dart';

class ClubImage extends StatelessWidget {
  const ClubImage({super.key, required this.club});

  final Club club;
  final double size = 32;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: club.imageUrl,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            if (club.score != 0)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: ScoreIndicator(
                      score: club.score,
                      scale: size,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
