import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/primary_swatch.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:provider/provider.dart';

import '../widgets/filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ClubList clubList = context.watch<ClubList>();
    double height = 250;
    double width = 180;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        elevation: 0.4,
        title: const Text(
          'Nightlife Zagreb',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: primaryColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black54,
            height: 1.0,
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Filter(),
              const SizedBox(height: 12),
              LayoutGrid(
                columnSizes: List.filled((MediaQuery.of(context).size.width / width).floor(), 152.px),
                rowSizes: List.filled((clubList.filteredClubs.length / (MediaQuery.of(context).size.width / width).floor()).ceil(), height.px),
                gridFit: GridFit.loose,
                columnGap: 20,
                children: clubList.filteredClubs.map((e) => ClubTile(club: e)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
