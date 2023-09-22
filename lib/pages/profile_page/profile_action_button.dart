import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({super.key, required this.action, this.icon, this.label, this.backgroundColor = Colors.black, this.width = 150})
      : assert((icon == null) ^ (label == null));

  final Icon? icon;
  final Text? label;
  final Color backgroundColor;
  final void Function()? action;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: action,
        child: Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black),
            color: backgroundColor,
          ),
          child: label == null ? const Icon(FontAwesomeIcons.google) : Center(child: label!),
        ),
      ),
    );
  }
}
