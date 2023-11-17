import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:provider/provider.dart';

class ClubGridView extends StatelessWidget {
  const ClubGridView({super.key});

  final double width = 148;

  @override
  Widget build(BuildContext context) {
    ClubList clubList = context.watch<ClubList>();

    return clubList.filteredClubs.isEmpty
        ? const SizedBox()
        : Center(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).size.width / width).floor(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: clubList.filteredClubs.length,
              itemBuilder: (context, index) {
                var club = clubList.filteredClubs[index];
                return Provider.value(value: club, child: const ClubTile());
              },
            ),
          );
  }
}
