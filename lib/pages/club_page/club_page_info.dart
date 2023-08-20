import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/widgets/translatable_text.dart';
import 'package:provider/provider.dart';

import '../../enums/contact.dart';
import '../../model/club.dart';
import '../../widgets/column_with_title.dart';
import '../../widgets/contact_display.dart';
import '../../widgets/day_of_week_display.dart';

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
          spacing: 12,
          children: [
            Column(
              children: [
                SizedBox.square(
                  dimension: 150,
                  child: Image.network(
                    club.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  club.name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  club.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              width: width,
              child: const Divider(
                height: 0,
                color: Colors.black,
                thickness: 1,
              ),
            ),
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
              title: "Contacts & Social Media",
              children: Contact.values.map((e) => ContactDisplay(data: club.contacts[e], contact: e)).toList(),
            ),
            ColumnWithTitle(
              width: width,
              title: "Work days",
              children: club.workHours.keys
                  .toList()
                  .where((element) => club.workHours[element]!.open)
                  .toList()
                  .rearrange((p0, p1) => p0.index - p1.index)
                  .map((dayOfWeek) => DayOfWeekDisplay(day: club.workHours[dayOfWeek]!, dayName: dayOfWeek.name.toUpperCase()))
                  .toList(),
            ),
            if (club.review != null)
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
