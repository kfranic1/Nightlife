import 'package:flutter/material.dart';

class ClubTextField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final void Function(String)? onChanged;
  final bool validate;
  final Icon? icon;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool expands;
  final TextAlignVertical? textAlignVertical;
  final bool? alignLabelWithHint;

  const ClubTextField(
      {Key? key,
      required this.labelText,
      required this.initialValue,
      this.icon,
      this.onChanged,
      this.validate = false,
      this.validator = defaultValidator,
      this.alignLabelWithHint,
      this.expands = false,
      this.maxLines = 1,
      this.textAlignVertical})
      : super(key: key);

  @override
  State<ClubTextField> createState() => _ClubTextFieldState();

  static String? defaultValidator(String? value) {
    return value == null || value.isEmpty ? "Element can't be empty" : null;
  }
}

class _ClubTextFieldState extends State<ClubTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(ClubTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        icon: widget.icon,
        labelText: widget.labelText,
        alignLabelWithHint: widget.alignLabelWithHint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      expands: widget.expands,
      textAlignVertical: widget.textAlignVertical,
      validator: widget.validate ? (widget.validator) : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
