import 'package:flutter/material.dart';

class Language with ChangeNotifier {
  static final Language _instance = Language._internal();

  factory Language() {
    return _instance;
  }

  Language._internal();

  Locale _locale = const Locale('hr');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  bool get isHr => locale == const Locale('hr');

  String translate(String textHr, String textEn) => isHr ? textHr : textEn;
}
