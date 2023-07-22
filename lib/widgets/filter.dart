import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/filters.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final TextEditingController _searchController = TextEditingController();
  BaseFilter _filter = BaseFilter.filters.first;

  @override
  Widget build(BuildContext context) {
    ClubList clubs = context.watch<ClubList>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => clubs.updateFilter(textFilter: value, filter: _filter),
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
              value: _filter.name,
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
                    _filter = BaseFilter.filters.firstWhere((element) => element.name == newValue);
                    clubs.updateFilter(textFilter: _searchController.text, filter: _filter);
                  });
                }
              },
              items: BaseFilter.filters
                  .map((baseFilter) => DropdownMenuItem(
                        value: baseFilter.name,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(baseFilter.name, style: const TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
