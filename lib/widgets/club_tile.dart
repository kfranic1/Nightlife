import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/widgets/club_image.dart';
import 'package:nightlife/widgets/seo_text.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class ClubTile extends StatelessWidget {
  final Club club;

  const ClubTile({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 240,
        width: 152,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.read<CustomRouterDelegate>().goToClub(club.name),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(child: ClubImage(club: club)),
                const SizedBox(height: 4),
                SEOText(
                  club.name,
                  textTagStyle: TextTagStyle.h1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SEOText(
                  club.location,
                  textTagStyle: TextTagStyle.h2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
