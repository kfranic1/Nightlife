import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';

import 'club_page_top.dart';

class ClubPage extends StatelessWidget {
  final Club club;
  const ClubPage({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClubPageTop(club: club),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(),
        ),
      ],
    );
  }
}
