import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:provider/provider.dart';

import 'club_edit_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    Club club = context.read<Club>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<CustomRouterDelegate>().goBack(),
          color: Colors.black,
          splashRadius: 0.1,
        ),
        title: Text(
          club.name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Builder(
        builder: (context) {
          Person? user = context.watch<Person?>();
          if (user == null) return const Center(child: Text("Please log in"));
          if (!user.isAdmin) return const Center(child: Text("Unauthorized access"));
          if (user.adminData!.clubId != club.id) return const Center(child: Text("You do not have access to this club"));
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ClubEditPage(),
          );
        },
      ),
    );
  }
}
