import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/auh_page.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:nightlife/widgets/language_icon_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();
    if (user == null) return const AuthPage();
    return Center(
      child: Column(
        children: [
          Text(user.displayName ?? ''),
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
  }
}
