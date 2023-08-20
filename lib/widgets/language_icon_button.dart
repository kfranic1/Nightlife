import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/language.dart';
import 'package:provider/provider.dart';

class LanguageIconButton extends StatelessWidget {
  const LanguageIconButton({super.key, required this.flagsCode, required this.locale});

  final FlagsCode flagsCode;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
      builder: (context, language, child) => IconButton(
        icon: ColorFiltered(
          colorFilter: ColorFilter.mode(
            language.locale == locale ? Colors.transparent : Colors.grey,
            BlendMode.saturation,
          ),
          child: Flag.fromCode(
            flagsCode,
            height: 24,
            width: 24,
          ),
        ),
        splashRadius: 0.1,
        onPressed: () => Language().setLocale(locale),
      ),
    );
  }
}
