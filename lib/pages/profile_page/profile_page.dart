import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:nightlife/widgets/language_icon_button.dart';
import 'package:provider/provider.dart';

import 'username.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Person? user = context.watch<Person?>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<CustomRouterDelegate>().goToHome(),
          color: Colors.black,
          splashRadius: 0.1,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            if (user != null)
              const Username()
            else
              SizedBox(
                height: 50,
                width: 320,
                child: ElevatedButton(
                  onPressed: () => context.read<CustomRouterDelegate>().goToLogin(),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Sign Up or Log In",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            const Expanded(child: SizedBox()),
            if (user?.role == Role.admin)
              ElevatedButton(
                onPressed: () => context
                    .read<CustomRouterDelegate>()
                    .goToAdmin(context.read<ClubList>().clubs.firstWhere((element) => element.id == user!.adminAccess).name),
                child: const Text("Admin Panel"),
              ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LanguageIconButton(flagsCode: FlagsCode.HR, locale: Locale('hr')),
                LanguageIconButton(flagsCode: FlagsCode.GB, locale: Locale('en')),
              ],
            ),
            const SizedBox(height: 20),
            if (user != null)
              TextButton.icon(
                label: const Text("Logout"),
                onPressed: () => context.read<AuthService>().signOut(),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
