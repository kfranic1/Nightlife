import 'package:flutter/foundation.dart';
import 'package:nightlife/firestore/firestore_service.dart';
import 'package:nightlife/helpers/filters.dart';

import '../model/club.dart';

class ClubList extends ChangeNotifier {
  List<Club> _clubs = [];
  List<Club> _filteredClubs = [];

  String _filterText = "";
  BaseFilter _filter = BaseFilter.filters.first;

  Future setup() async {
    return await FirestoreService.getClubs().then((value) {
      _clubs = value;
      _filteredClubs = List.from(_clubs);
      notifyListeners();
    });
  }

  String get filterText => _filterText;
  BaseFilter get filter => _filter;
  List<Club> get clubs => _clubs;
  List<Club> get filteredClubs => _filteredClubs;

  void updateFilter(BaseFilter filter) {
    _filter = filter;
    _applyFilter();
  }

  void updateText(String text) {
    _filterText = text;
    _applyFilter();
  }

  void _applyFilter() {
    _filteredClubs = _clubs.where((club) => club.name.toLowerCase().contains(_filterText.toLowerCase())).toList();
    _filter.applyFilter(_filteredClubs);
    notifyListeners();
  }

  Club findClubByName(String name) => _clubs.firstWhere((club) => club.name == name);
}
