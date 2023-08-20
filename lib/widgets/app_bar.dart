import 'package:flutter/material.dart';

AppBar appBar({required void Function()? onPressedHome, void Function()? onPressedDrawer}) {
  return AppBar(
    titleSpacing: 0,
    leadingWidth: 0,
    automaticallyImplyLeading: false,
    elevation: 0.4,
    title: TextButton(
      style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
      onPressed: onPressedHome,
      child: const Text(
        'Nightlife Zagreb',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(4.0),
      child: Container(
        color: Colors.black54,
        height: 1.0,
      ),
    ),
    actions: [
      IconButton(
          onPressed: onPressedDrawer,
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ))
    ],
  );
}
