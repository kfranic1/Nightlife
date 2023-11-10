import 'package:flutter/material.dart';
import 'package:nightlife/pages/home_page/subpages/club_grid_view.dart';
import 'package:nightlife/pages/home_page/subpages/google_maps_page.dart';
import 'package:nightlife/widgets/gradient_background.dart';
import 'package:nightlife/widgets/filter.dart';
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: GradientBackground(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                controller: controller,
                tabs: const [
                  Center(child: Text("CLUBS")),
                  Center(child: Text("MAP")),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Filter(),
                    Expanded(
                      child: TabBarView(
                        controller: controller,
                        children: const [
                          ClubGridView(),
                          GoogleMapsView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
