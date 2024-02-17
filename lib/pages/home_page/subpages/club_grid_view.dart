import 'package:flutter/material.dart';
import 'package:nightlife/services/club_data_service.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:provider/provider.dart';

class ClubGridView extends StatelessWidget {
  const ClubGridView({super.key});

  final double width = 148;

  @override
  Widget build(BuildContext context) {
    ClubDataService clubDataService = context.watch<ClubDataService>();

    return clubDataService.filteredClubs.isEmpty
        ? const SizedBox()
        : Center(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).size.width / width).floor(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: clubDataService.filteredClubs.length,
              itemBuilder: (context, index) {
                var club = clubDataService.filteredClubs[index];
                return Provider.value(value: club, child: const ClubTile());
              },
            ),
          );
  }
}
