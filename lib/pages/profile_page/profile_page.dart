import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:nightlife/widgets/language_icon_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Person? user = context.watch<Person?>();
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            children: [
              if (user != null)
                Text(user.name)
              else
                TextButton(
                  onPressed: () => context.read<CustomRouterDelegate>().goToLogin(),
                  child: const Text("Log in"),
                ),
              if (context.read<AuthService>().hasUser)
                IconButton(
                  onPressed: () => context.read<AuthService>().signOut(),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageIconButton(flagsCode: FlagsCode.HR, locale: Locale('hr')),
                  LanguageIconButton(flagsCode: FlagsCode.GB, locale: Locale('en')),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
