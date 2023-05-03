import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:nightlife/firestore/firestore_service.dart';

import 'club.dart';

class ClubList extends ChangeNotifier {
  List<Club> _clubs = [];
  List<Club> _filteredClubs = [];

  ClubList() {
    FirestoreService.getClubs().then((value) {
      _clubs = value;
      _filteredClubs = List.from(_clubs);
      notifyListeners();
    });
  }

  UnmodifiableListView<Club> get allClubs => UnmodifiableListView(_clubs);

  UnmodifiableListView<Club> get filteredClubs => UnmodifiableListView(_filteredClubs);

  void updateFilteredClubs(List<Club> newFilteredClubs) {
    _filteredClubs.clear();
    _filteredClubs.addAll(newFilteredClubs);
    notifyListeners();
  }
}
