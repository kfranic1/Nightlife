import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/subpages/auth_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(
      isLogin: false,
      title: "Sign Up",
      message: "Create Account",
      swapQuestion: "Already have a profile? ",
      swapAction: "Log In",
    );
  }
}
