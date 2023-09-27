import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/review_display.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

import 'club_page_info.dart';

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    Club club = context.read<Club>();
    return Seo.head(
      tags: [
        MetaTag(name: 'title', content: 'Nightlife Zagreb - ${club.name}'),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NestedPageView(
          scrollDirection: Axis.vertical,
          children: [
            const ClubPageInfo(),
            if (club.reviewId != null) ReviewDisplay(reviewId: club.reviewId!),
          ],
        ),
      ),
    );
  }
}
