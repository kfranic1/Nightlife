import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/extensions/social_media_extension.dart';
import 'package:nightlife/extensions/string_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/column_with_title.dart';
import 'package:nightlife/widgets/contact_display.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubContactInfo extends StatelessWidget {
  const ClubContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Club club = context.read<Club>();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColumnWithTitle(
            width: min(400, MediaQuery.of(context).size.width - 20),
            title: "Contacts",
            children: club.contacts.keys
                .where((key) => !club.contacts[key].isNullOrEmpty)
                .toList()
                .rearrange((p0, p1) => p0.index.compareTo(p1.index))
                .map((key) => ContactDisplay(data: club.contacts[key]!, contact: key))
                .toList(),
          ),
          ColumnWithTitle(
            width: min(400, MediaQuery.of(context).size.width - 20),
            title: "Social Media",
            children: club.socialMedia.keys
                .where((key) => !club.socialMedia[key].isNullOrEmpty)
                .toList()
                .map(
                  (key) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ListTile(
                      onTap: () async => await launchUrl(Uri.parse("${club.socialMedia[key]}")),
                      leading: Icon(key.icon),
                      title: Text(club.socialMedia[key]!.substring(8)),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
