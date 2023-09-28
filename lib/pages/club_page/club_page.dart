import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/club_page/club_name_and_image.dart';
import 'package:nightlife/widgets/review_display.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

import 'club_page_info.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 1, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Club club = context.read<Club>();
    return Seo.head(
      tags: [
        MetaTag(name: 'title', content: 'Nightlife Zagreb - ${club.name}'),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: ClubImageAndName(club: club)),
            const SizedBox(height: 16),
            Expanded(
              child: NestedTabBarView(
                controller: tabController,
                children: [
                  const Center(
                    child: Text(
                      "We are working on this feature. \nFollow us on instagram to get the latest updates.",
                      textAlign: TextAlign.center,
                    ),
                  ), //TODO create a reservations page
                  const ClubPageInfo(),
                  if (club.reviewId == null) const Center(child: Text("This club has not yet been reviewed.")) else ReviewDisplay(reviewId: club.reviewId!),
                ],
              ),
            ),
            TabBar(
              controller: tabController,
              tabs: const [
                Column(
                  children: [
                    Icon(Icons.table_bar_outlined, color: Colors.black),
                    Text("Reservations", style: TextStyle(color: Colors.black)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.info_outline, color: Colors.black),
                    Text("Info", style: TextStyle(color: Colors.black)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.rate_review_outlined, color: Colors.black),
                    Text("Review", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
