import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/enums/day_of_week.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/geopoint_extension.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/model/club.dart';

class ClubList extends ChangeNotifier {
  List<Club> _clubs = [];
  List<Club> _filteredClubs = [];
  bool _showOpenTonightOnly = false;

  String _filterText = "";
  TypeOfMusic? _typeOfMusic;

  Future setup() async {
    await Club.getClubs().then((value) {
      _clubs = value;
      _clubs.shuffle();
      _filteredClubs = List.from(_clubs);
      _applyFilter();
    });
  }

  bool get isFiltered => _filterText.isNotEmpty || _typeOfMusic != null || _showOpenTonightOnly;

  String get filterText => _filterText;
  TypeOfMusic? get typeOfMusic => _typeOfMusic;
  bool get showOpenTonightOnly => _showOpenTonightOnly;
  List<Club> get clubs => _clubs;
  List<Club> get filteredClubs => _filteredClubs;

  void clearFiler() {
    _filterText = '';
    _typeOfMusic = null;
    _showOpenTonightOnly = false;
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

  void updateShowOpenTonightOnly(bool value) {
    _showOpenTonightOnly = value;
    _applyFilter();
  }

  void _applyFilter() {
    _filteredClubs = _clubs.where((club) => club.name.toLowerCase().contains(_filterText.toLowerCase())).toList();

    if (_typeOfMusic != null) _filteredClubs = _filteredClubs.where((element) => element.typeOfMusic.contains(_typeOfMusic)).toList();

    if (_showOpenTonightOnly) {
      DateTime now = DateTime.now();
      DayOfWeek today = DayOfWeek.values[now.weekday - 1];
      _filteredClubs = _filteredClubs.where((element) => element.workHours[today]!.open).toList();
    }

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

  void bringForward(Club club){
    _filteredClubs.move(club, _filteredClubs.length - 1);
    notifyListeners();
  }
}
