import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/column_with_title.dart';
import 'package:nightlife/widgets/day_of_week_display.dart';
import 'package:nightlife/widgets/google_maps_preview.dart';
import 'package:provider/provider.dart';

class ClubMainInfo extends StatelessWidget {
  const ClubMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = min(400, MediaQuery.of(context).size.width - 20);
    Club club = context.read<Club>();
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 16,
          children: [
            /*if (club.descriptionEn.isNotEmpty && club.descriptionHr.isNotEmpty) //TODO temporary - each club should have a non empty description
              SizedBox(
                width: width,
                child: TranslatableText(
                  textHr: club.descriptionHr,
                  textEn: club.descriptionEn,
                  maxLines: null,
                ),
              ),*/
            const GoogleMapsPreview(),
            ColumnWithTitle(
              width: width,
              title: "Location",
              children: [
                ListTile(
                  onTap: () => club.location.openMap(),
                  leading: const Icon(Icons.location_on),
                  title: Text(club.location.name),
                ),
              ],
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
          ],
        ),
      ),
    );
  }
}
