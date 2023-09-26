import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/club_image.dart';
import 'package:nightlife/widgets/seo_text.dart';
import 'package:seo/seo.dart';

class ClubImageAndName extends StatelessWidget {
  const ClubImageAndName({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 180,
          child: ClubImage(club: club),
        ),
        const SizedBox(height: 16),
        SEOText(
          club.name,
          textTagStyle: TextTagStyle.h1,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
