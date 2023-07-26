import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  const FormButton({super.key, required GlobalKey<FormState> formStateKey, required Future<void> Function() action})
      : _formStateKey = formStateKey,
        _action = action;

  final GlobalKey<FormState> _formStateKey;
  final Future<void> Function() _action;

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Background color
      ),
      onPressed: loading
          ? null
          : () async {
              setState(() => loading = true);
              if (widget._formStateKey.currentState!.validate()) {
                widget._formStateKey.currentState!.save();
                try {
                  await widget._action.call();
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operation successful')));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: ${error.toString()}')));
                }
              }
              setState(() => loading = false);
            },
      child: loading ? const CircularProgressIndicator() : const Text("Save"),
    );
  }
}
