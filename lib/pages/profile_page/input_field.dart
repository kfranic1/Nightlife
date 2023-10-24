import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    Icon? icon,
    bool obscureText = false,
  })  : _controller = controller,
        _labelText = labelText,
        _icon = icon,
        _obscureText = obscureText;

  final TextEditingController _controller;
  final String _labelText;
  final Icon? _icon;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
          child: _icon,
        ),
        labelText: _labelText,
      ),
      controller: _controller,
    );
  }
}
