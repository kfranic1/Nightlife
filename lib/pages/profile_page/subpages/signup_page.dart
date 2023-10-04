import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/pages/profile_page/profile_action_button.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.login});

  final VoidCallback login;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService auth = context.read<AuthService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputField(
            controller: _name,
            labelText: 'Name',
            icon: const Icon(Icons.person),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputField(
            controller: _email,
            labelText: 'email',
            icon: const Icon(Icons.email),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputField(
            controller: _password,
            labelText: 'password',
            icon: const Icon(Icons.password),
            obscureText: true,
          ),
        ),
        ProfileActionButton(
          action: () => auth.signUp(
            email: _email.text,
            password: _password.text,
            name: _name.text,
          ),
          label: const Text(
            "SIGN UP",
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
            onPressed: widget.login,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                  ),
                  TextSpan(
                    text: "Log in",
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
