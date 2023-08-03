import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/review_display.dart';
import 'package:provider/provider.dart';

import 'club_page_info.dart';

class ClubPage extends StatelessWidget {
  final Club club;
  const ClubPage({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedPageView(
            scrollDirection: Axis.vertical,
            children: [
              ClubPageInfo(club: club),
              if(club.review != null) Provider.value(
                value: club.review,
                child: const ReviewDisplay(),
              ),
            ],
          ),
        );
      },
    );
  }
}
