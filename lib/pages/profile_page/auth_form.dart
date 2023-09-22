import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final List<Widget> inputFields;
  final List<Widget> actionButtons;
  final Widget switchText;

  const AuthForm({
    Key? key,
    required this.inputFields,
    required this.actionButtons,
    required this.switchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...inputFields,
        ...actionButtons,
        switchText,
      ],
    );
  }
}
