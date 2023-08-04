import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  const FormButton({super.key, required Future<void> Function() action, required String label, Color? color})
      : _action = action,
        _label = label,
        _color = color;

  final Future<void> Function() _action;
  final String _label;
  final Color? _color;

  @override
  State<FormButton> createState() => _FormButtonState();

  static Future tryAction(BuildContext context, Future<void> Function() action) async {
    try {
      await action.call();
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Operation successfull'),
          duration: Duration(seconds: 1),
        ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: ${error.toString()}')));
    }
  }
}

class _FormButtonState extends State<FormButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: widget._color),
            onPressed: () async {
              setState(() => loading = true);
              await widget._action.call();
              setState(() => loading = false);
            },
            child: Text(widget._label),
          );
  }
}
