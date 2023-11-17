import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/widgets/club_image.dart';
import 'package:nightlife/widgets/seo_text.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class ClubTile extends StatelessWidget {
  const ClubTile({super.key});

  @override
  Widget build(BuildContext context) {
    final Club club = context.watch<Club>();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<CustomRouterDelegate>().goToClub(club.name),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox.square(child: ClubImage()),
            const SizedBox(height: 4),
            SEOText(
              club.name,
              textTagStyle: TextTagStyle.h1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SEOText(
              club.location.name,
              textTagStyle: TextTagStyle.h2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
