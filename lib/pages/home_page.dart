import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:provider/provider.dart';

import '../widgets/filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = min(1000, MediaQuery.of(context).size.width * 0.95);

    ClubList clubList = context.watch<ClubList>();
    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(width: width, child: const Filter()),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => ClubTile(
              club: clubList.filteredClubs[index],
              width: width,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: clubList.filteredClubs.length,
          ),
        ),
      ],
    );
  }
}
