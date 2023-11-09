import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/model/club.dart';

class SelectedClub with ChangeNotifier {
  Club? _club;

  Club? get club => _club;

  void select(Club? club) {
    _club = club;
    notifyListeners();
  }

  void selectNext(List<Club> clubs) {
    if (clubs.isNotEmpty && _club != null) select(clubs.next(_club!));
  }

  void selectPrevious(List<Club> clubs) {
    if (clubs.isNotEmpty && _club != null) select(clubs.previous(_club!));
  }
}
