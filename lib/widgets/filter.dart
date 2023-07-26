import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:nightlife/helpers/filters.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ClubList clubs = context.read<ClubList>();
    _searchController.text = clubs.filterText;
  }

  @override
  Widget build(BuildContext context) {
    ClubList clubs = context.watch<ClubList>();
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              controller: _searchController,
              onChanged: (value) => clubs.updateText(value),
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: DefaultBoxDecoration(),
          child: DropdownButton<BaseFilter>(
            value: clubs.filter,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(),
            focusColor: Colors.transparent,
            onChanged: (BaseFilter? selectedFilter) => clubs.updateFilter(selectedFilter!),
            items: BaseFilter.filters
                .map((baseFilter) => DropdownMenuItem<BaseFilter>(
                      value: baseFilter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(baseFilter.name, style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
