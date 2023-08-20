import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/widgets/language_icon_button.dart';

class OptionsDrawer extends StatelessWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
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
}
