import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({super.key, required this.action, this.icon, this.label, this.backgroundColor = Colors.black, this.width = 150})
      : assert((icon == null) ^ (label == null));

  final Icon? icon;
  final Text? label;
  final Color backgroundColor;
  final Future<String?> Function() action;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          String? message = await action();
          if (message != null && context.mounted)
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ));
        },
        child: Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black),
            color: backgroundColor,
          ),
          child: label == null ? icon : Center(child: label!),
        ),
      ),
    );
  }
}
