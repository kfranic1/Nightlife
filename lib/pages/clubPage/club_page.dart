import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/review.dart';
import 'package:nightlife/widgets/review_display.dart';
import 'package:provider/provider.dart';

import 'club_page_info.dart';

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    Review? review = context.read<Club>().review;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedPageView(
            scrollDirection: Axis.vertical,
            children: [
              const ClubPageInfo(),
              if(review != null) Provider.value(
                value: review,
                child: const ReviewDisplay(),
              ),
            ],
          ),
        );
      },
    );
  }
}
