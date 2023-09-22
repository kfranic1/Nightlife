import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/login_page.dart';
import 'package:nightlife/pages/profile_page/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;
  @override
  Widget build(BuildContext context) {
    return showLogin ? LoginPage(signUp: () => setState(() => showLogin = false)) : SignUpPage(login: () => setState(() => showLogin = true));
  }
}
