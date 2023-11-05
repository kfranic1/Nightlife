import 'package:cached_network_image/cached_network_image.dart';
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
      child: Seo.image(
        alt: "Nightlife Zagreb - ${club.name}",
        src: club.imageUrl,
        child: CachedNetworkImage(
          imageUrl: club.imageUrl,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
