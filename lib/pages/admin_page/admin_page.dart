import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/pages/admin_page/administration_page.dart';
import 'package:nightlife/pages/admin_page/club_edit_page.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:nightlife/widgets/custom_material_page.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Club club = context.watch<Club>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<CustomRouterDelegate>().goBack(),
          splashRadius: 0.1,
        ),
        title: Text("${club.name} - Dashboard"),
      ),
      body: GradientBackground(
        child: StreamBuilder<Person?>(
          stream: context.read<AuthService>().authStateChanges,
          builder: (context, snapshot) {
            Person? user = snapshot.data;
            if (user == null) return const Center(child: Text("Please log in"));
            if (!user.hasAdminAccess) return const Center(child: Text("Unauthorized access"));
            if (user.adminData!.clubId != club.id) return const Center(child: Text("You do not have access to this club"));

            List<Text> tabs = [];
            List<Widget> tabViews = [];

            tabs.add(const Text("Reservations"));
            tabViews.add(const SizedBox());

            if (user.isAdmin) {
              tabs.addAll(const [
                Text("Organization"),
                Text("Club Data Edit"),
              ]);
              tabViews.addAll(const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AdministrationPage(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClubEditPage(),
                ),
              ]);
            }

            tabController = TabController(length: tabs.length, vsync: this);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    labelPadding: EdgeInsets.zero,
                    tabs: tabs,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: tabViews,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
