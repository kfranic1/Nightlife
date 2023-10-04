import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/pages/profile_page/input_field.dart';
import 'package:nightlife/pages/profile_page/profile_action_button.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.signUp});
  final VoidCallback signUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService auth = context.read<AuthService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputField(
            controller: _email,
            labelText: 'Email',
            icon: const Icon(Icons.email),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputField(
            controller: _password,
            labelText: 'Password',
            icon: const Icon(Icons.lock),
            obscureText: true,
          ),
        ),
        ProfileActionButton(
          action: () => auth.signIn(email: _email.text, password: _password.text),
          label: const Text(
            "LOG IN",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ProfileActionButton(
          action: () => auth.signInWithGoogle(),
          backgroundColor: Colors.white,
          icon: const Icon(
            FontAwesomeIcons.google,
            color: Colors.black,
          ),
        ),
        TextButton(
            onPressed: widget.signUp,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                style: TextStyle(color: Colors.black),
              ),
            ))
      ],
    );
  }
}
