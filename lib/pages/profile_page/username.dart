import 'package:flutter/material.dart';
import 'package:nightlife/model/person.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  bool _isEditing = false;
  late final TextEditingController _controller;
  late final Person user;

  @override
  void initState() {
    user = context.read<Person?>()!;
    _controller = TextEditingController(text: user.name);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          autofocus: true,
          readOnly: !_isEditing,
          controller: _controller,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_isEditing) await user.updateName(_controller.text);
            setState(() => _isEditing = !_isEditing);
          },
          child: Text(_isEditing ? 'Save' : 'Edit'),
        )
      ],
    );
  }
}
