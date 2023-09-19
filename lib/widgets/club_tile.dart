import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/club.dart';
import '../routing/custom_router_delegate.dart';
import 'club_image.dart';

class ClubTile extends StatelessWidget {
  final Club club;

  const ClubTile({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 220,
        width: 152,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.read<CustomRouterDelegate>().goToClub({"name": club.name}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(child: ClubImage(club: club)),
                const SizedBox(height: 4),
                Text(
                  club.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  club.location,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
