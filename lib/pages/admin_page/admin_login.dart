import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/profile_action_button.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              controller: _email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              controller: _password,
            ),
          ),
          ProfileActionButton(
            action: () => context.read<AuthService>().signIn(email: _email.text, password: _password.text),
            label: const Text(
              "LOG IN",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
