import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/club_page/club_name_and_image.dart';
import 'package:nightlife/pages/club_page/social_media_links.dart';
import 'package:nightlife/pages/club_page/club_subpages/club_info.dart';
import 'package:nightlife/pages/club_page/club_subpages/reservation_display.dart';
import 'package:nightlife/pages/club_page/club_subpages/review_display.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
            SizedBox(
              height: 50,
              width: min(400, MediaQuery.of(context).size.width - 20),
              child: TabBar(
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.black,
                labelColor: primaryColor,
                tabs: const [
                  TabBarElement("DETAILS"),
                  TabBarElement("RESERVATIONS"),
                  TabBarElement("REVIEW"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NestedTabBarView(
                controller: tabController,
                children: [
                  const ClubInfo(),
                  const ReservationDisplay(),
                  if (club.hasReview) ReviewDisplay(reviewId: club.id) else const Center(child: Text("This club has not yet been reviewed.")),
                ],
              ),
            ),
            SocialMediaLinks(club: club),
          ],
        ),
      ),
    );
  }
}

class TabBarElement extends StatelessWidget {
  const TabBarElement(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
