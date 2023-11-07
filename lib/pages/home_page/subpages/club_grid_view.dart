import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:provider/provider.dart';

class ClubGridView extends StatelessWidget {
  const ClubGridView({super.key});

  final double height = 218;
  final double width = 180;

  @override
  Widget build(BuildContext context) {
    ClubList clubList = context.watch<ClubList>();

    return clubList.filteredClubs.isEmpty
        ? const SizedBox()
        : SingleChildScrollView(
            child: Center(
              child: LayoutGrid(
                columnSizes: List.filled((MediaQuery.of(context).size.width / width).floor(), 148.px),
                rowSizes: List.filled((clubList.filteredClubs.length / (MediaQuery.of(context).size.width / width).floor()).ceil(), height.px),
                gridFit: GridFit.loose,
                columnGap: 16,
                rowGap: 16,
                children: clubList.filteredClubs.map((club) => Provider.value(value: club, child: const ClubTile())).toList(),
              ),
            ),
          );
  }
}
