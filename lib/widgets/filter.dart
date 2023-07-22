import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:provider/provider.dart';

import '../model/club.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSorting = 'none';

  void _applyFilters() {
    ClubList clubListModel = context.read<ClubList>();

    // Filter clubs based on search text
    List<Club> filteredClubs = clubListModel.allClubs.where((club) => club.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

    // Sort clubs based on the selected sorting method
    if (_selectedSorting == 'alphabetical') {
      filteredClubs.sort((a, b) => a.name.compareTo(b.name));
    } else if (_selectedSorting == 'score') {
      filteredClubs.sort((a, b) => b.score.compareTo(a.score));
    }

    // Update the filtered clubs in the ClubList model
    clubListModel.updateFilteredClubs(filteredClubs);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _applyFilters();
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<String>(
              value: _selectedSorting == 'none' ? null : _selectedSorting,
              hint: const Text("Filter"),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(),
              focusColor: Colors.transparent,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSorting = newValue;
                    _applyFilters();
                  });
                }
              },
              items: const [
                DropdownMenuItem(
                  value: 'none',
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Default', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
                DropdownMenuItem(
                  value: 'alphabetical',
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Alphabetical', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
                DropdownMenuItem(
                  value: 'score',
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Score', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
