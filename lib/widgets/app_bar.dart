import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/widgets/language_icon_button.dart';

AppBar appBar({required void Function()? onPressed}) {
  return AppBar(
    titleSpacing: 0,
    leadingWidth: 0,
    automaticallyImplyLeading: false,
    elevation: 0.4,
    title: TextButton(
      style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
      onPressed: onPressed,
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
      TextButton.icon(
        style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
        onPressed: () async => {}, //await launchUrl(Uri.parse("address")),
        label: const Text(
          "Visit our Instagram",
          maxLines: 1,
          style: TextStyle(fontSize: 12),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.instagram,
          color: Colors.purple,
        ),
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LanguageIconButton(flagsCode: FlagsCode.HR, locale: Locale('hr')),
          LanguageIconButton(flagsCode: FlagsCode.GB, locale: Locale('en')),
        ],
      )
    ],
  );
}
