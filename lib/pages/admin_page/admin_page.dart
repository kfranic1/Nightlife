import 'package:flutter/material.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:provider/provider.dart';

import 'club_edit_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<CustomRouterDelegate>().goBack(),
          color: Colors.black,
          splashRadius: 0.1,
        ),
        title: Text(
          context.read<Club>().name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Builder(
        builder: (context) {
          Person? user = context.watch<Person?>();
          if (user == null) return const Center(child: Text("Please log in"));
          if (user.role != Role.admin) return const Center(child: Text("Unauthorized access"));
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ClubEditPage(),
          );
        },
      ),
    );
  }
}
