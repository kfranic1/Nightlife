import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/subpages/auth_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(
      isLogin: true,
      title: "Log In",
      message: "Welcome Back",
      swapQuestion: "Don't have a profile? ",
      swapAction: "Sign Up",
    );
  }
}
