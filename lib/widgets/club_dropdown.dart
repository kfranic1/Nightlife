import 'package:flutter/material.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';

import '../model/club.dart';

class ClubDropdown extends StatelessWidget {
  const ClubDropdown({
    super.key,
    required Club club,
    required List<Club> clubs,
    required Function(Club?)? onChanged,
  })  : _club = club,
        _clubs = clubs,
        _onChanged = onChanged;

  final Club _club;
  final List<Club> _clubs;
  final Function(Club?)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DefaultBoxDecoration(),
      child: DropdownButton<Club>(
        value: _club,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        focusColor: Colors.transparent,
        onChanged: _onChanged,
        items: _clubs.map((club) => clubDropdownMenuItem(club)).toList(),
      ),
    );
  }

  DropdownMenuItem<Club> clubDropdownMenuItem(Club club) {
    return DropdownMenuItem<Club>(
      value: club,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          club.name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
