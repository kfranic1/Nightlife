import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/club_page/club_subpages/club_info.dart';
import 'package:nightlife/pages/club_page/club_subpages/reservation_display.dart';
import 'package:nightlife/pages/club_page/club_subpages/review_display.dart';
import 'package:nightlife/pages/club_page/social_media_links.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/widgets/club_image.dart';
import 'package:nightlife/widgets/club_like_button.dart';
import 'package:nightlife/widgets/custom_material_page.dart';
import 'package:nightlife/widgets/seo_text.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Club club = context.read<Club>();
    return Seo.head(
      tags: [
        MetaTag(name: 'title', content: 'Nightlife Zagreb - ${club.name}'),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<CustomRouterDelegate>().goBack(),
            splashRadius: 0.1,
          ),
          titleSpacing: 0,
          title: SEOText(
            club.name,
            textTagStyle: TextTagStyle.h1,
          ),
          actions: const [ClubLikeButton()],
        ),
        extendBodyBehindAppBar: true,
        body: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox.square(
                  dimension: 156,
                  child: ClubImage(),
                ),
                SizedBox(
                  height: 50,
                  width: min(400, MediaQuery.of(context).size.width - 20),
                  child: TabBar(
                    controller: tabController,
                    tabs: const [
                      Text("DETAILS"),
                      Text("RESERVATIONS"),
                      Text("REVIEW"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: NestedTabBarView(
                    controller: tabController,
                    children: const [
                      ClubInfo(),
                      ReservationDisplay(),
                      ReviewDisplay(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const SocialMediaLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
