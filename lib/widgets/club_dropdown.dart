import 'package:flutter/material.dart';
import 'package:nightlife/helpers/decorated_container.dart';
import 'package:nightlife/model/club.dart';

class ClubDropdown extends StatelessWidget {
  const ClubDropdown({
    super.key,
    required this.club,
    required this.clubs,
    required this.onChanged,
  });

  final Club club;
  final List<Club> clubs;
  final Function(Club?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      padding: const EdgeInsets.only(left: 8),
      child: DropdownButton<Club>(
        value: club,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        focusColor: Colors.transparent,
        onChanged: onChanged,
        items: clubs.map((club) => clubDropdownMenuItem(club)).toList(),
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
