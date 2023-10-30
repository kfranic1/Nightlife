import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/geopoint_extension.dart';
import 'package:nightlife/helpers/filters.dart';
import 'package:nightlife/model/club.dart';

class ClubList extends ChangeNotifier {
  List<Club> _clubs = [];
  List<Club> _filteredClubs = [];

  String _filterText = "";
  TypeOfMusic? _typeOfMusic;
  BaseFilter _filter = BaseFilter.filters.first;

  Future setup() async {
    await Club.getClubs().then((value) {
      _clubs = value;
      _clubs.shuffle();
      _filteredClubs = List.from(_clubs);
      _applyFilter();
    });
  }

  String get filterText => _filterText;
  TypeOfMusic? get typeOfMusic => _typeOfMusic;
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

  void updateTypeOfMusic(TypeOfMusic? typeOfMusic) {
    _typeOfMusic = typeOfMusic;
    _applyFilter();
  }

  void _applyFilter() {
    _filteredClubs = _clubs.where((club) => club.name.toLowerCase().contains(_filterText.toLowerCase())).toList();
    if (_typeOfMusic != null) _filteredClubs = _filteredClubs.where((element) => element.typeOfMusic.contains(_typeOfMusic)).toList();
    _filter.applyFilter(_filteredClubs);
    notifyListeners();
  }

  Club? findClubByName(String name) {
    if (!clubs.any((club) => club.name == name)) return null;
    return _clubs.firstWhere((club) => club.name == name);
  }

  LatLng get clubCenter => LatLng(
        clubs.map((club) => club.location.pin.latLng.latitude).reduce((a, b) => a + b) / clubs.length,
        clubs.map((club) => club.location.pin.latLng.longitude).reduce((a, b) => a + b) / clubs.length,
      );
}
