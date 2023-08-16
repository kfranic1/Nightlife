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
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    Text(
                      "LAST REVIEWED",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 12),
                    if (clubList.lastReviewed != null) ClubTile(club: clubList.lastReviewed!, width: width),
                    SizedBox(
                      width: width,
                      child: const Divider(
                        color: Colors.black,
                        height: 24,
                        thickness: 1,
                      ),
                    ),
                    Text(
                      "CLUBS",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ClubTile(
                  club: clubList.filteredClubs[index],
                  width: width,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemCount: clubList.filteredClubs.length,
              ),
            ],
          ),
        )
      ],
    );
  }
}
