import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/pages/club_page/club_name_and_image.dart';
import 'package:nightlife/widgets/translatable_text.dart';
import 'package:provider/provider.dart';

import '../../model/club.dart';
import '../../widgets/column_with_title.dart';
import '../../widgets/contact_display.dart';
import '../../widgets/day_of_week_display.dart';
import 'social_media_links.dart';

class ClubPageInfo extends StatefulWidget {
  const ClubPageInfo({super.key});

  @override
  State<ClubPageInfo> createState() => _ClubPageInfoState();
}

class _ClubPageInfoState extends State<ClubPageInfo> with AutomaticKeepAliveClientMixin<ClubPageInfo> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = min(400, MediaQuery.of(context).size.width - 20);
    Club club = context.watch<Club>();
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Center(child: ClubImageAndName(club: club)),
            if (club.descriptionEn.isNotEmpty && club.descriptionHr.isNotEmpty) //TODO temporary - each club should have a non empty description
              SizedBox(
                width: width,
                child: TranslatableText(
                  textHr: club.descriptionHr,
                  textEn: club.descriptionEn,
                  maxLines: null,
                ),
              ),
            ColumnWithTitle(
              width: width,
              title: "Contacts",
              children: club.contacts.keys
                  .where((key) => club.contacts[key] != null)
                  .toList()
                  .rearrange((p0, p1) => p0.index.compareTo(p1.index))
                  .map((key) => ContactDisplay(data: club.contacts[key]!, contact: key))
                  .toList(),
            ),
            ColumnWithTitle(
              width: width,
              title: "Work days",
              children: club.workHours.values.every((element) => !element.open)
                  ? [const Text("The club is currently closed")]
                  : club.workHours.keys
                      .where((element) => club.workHours[element]!.open)
                      .toList()
                      .rearrange((p0, p1) => p0.index - p1.index)
                      .map((dayOfWeek) => DayOfWeekDisplay(day: club.workHours[dayOfWeek]!, dayName: dayOfWeek.name.toUpperCase()))
                      .toList(),
            ),
            SocialMediaLinks(club: club),
            if (club.reviewId != null)
              const Text(
                "Scroll down to see the review",
                style: TextStyle(color: Colors.grey),
              )
          ],
        ),
      ),
    );
  }
}
