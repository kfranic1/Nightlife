import 'package:flutter/foundation.dart';
import 'package:nightlife/firestore/firestore_service.dart';
import 'package:nightlife/helpers/filters.dart';

import '../model/club.dart';

class ClubList extends ChangeNotifier {
  List<Club> _clubs = [];
  List<Club> filteredClubs = [];

  Future setup() async {
    return await FirestoreService.getClubs().then((value) {
      _clubs = value;
      filteredClubs = List.from(_clubs);
      notifyListeners();
    });
  }

  void updateFilter({required String textFilter, required BaseFilter filter}) {
    filteredClubs = _clubs.where((club) => club.name.toLowerCase().contains(textFilter.toLowerCase())).toList();
    filter.applyFilter(filteredClubs);
    notifyListeners();
  }

  Club findClubByName(String name) => _clubs.firstWhere((club) => club.name == name);
}
