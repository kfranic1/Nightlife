import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/pages/google_maps_page/google_maps_page.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/widgets/club_tile.dart';
import 'package:nightlife/widgets/custom_material_page.dart';
import 'package:nightlife/widgets/filter.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ClubList clubList = context.watch<ClubList>();
    double height = 250;
    double width = 180;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 0,
        title: GradientText(
          'NIGHTLIFE ZAGREB',
          style: Theme.of(context).textTheme.headlineLarge,
          colors: const [
            Color.fromARGB(255, 0, 255, 255),
            Color.fromARGB(255, 255, 0, 255),
          ],
          overflow: TextOverflow.visible,
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<CustomRouterDelegate>().goToProfile(),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                controller: controller,
                tabs: const [
                  Center(child: Text("CLUBS")),
                  Center(child: Text("MAP")),
                ],
              ),
              const Filter(),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          if (clubList.filteredClubs.isNotEmpty)
                            LayoutGrid(
                              columnSizes: List.filled((MediaQuery.of(context).size.width / width).floor(), 152.px),
                              rowSizes: List.filled((clubList.filteredClubs.length / (MediaQuery.of(context).size.width / width).floor()).ceil(), height.px),
                              gridFit: GridFit.loose,
                              columnGap: 20,
                              children: clubList.filteredClubs.map((club) => Provider.value(value: club, child: const ClubTile())).toList(),
                            ),
                        ],
                      ),
                    ),
                    const GoogleMapsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
