import 'package:flutter/material.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/filters.dart';
import 'package:nightlife/helpers/primary_swatch.dart';
import 'package:nightlife/widgets/dropdown_filter.dart';
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
    _searchController.text = context.read<ClubList>().filterText;
    _searchController.addListener(() => context.read<ClubList>().updateText(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ClubList clubs = context.watch<ClubList>();
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: primaryColor)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: primaryColor)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
                splashRadius: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownFilter<TypeOfMusic?>(
                label: "Genre",
                value: clubs.typeOfMusic,
                onChanged: (TypeOfMusic? type) => clubs.updateTypeOfMusic(type),
                onClear: () => clubs.updateTypeOfMusic(null),
                items: Map.fromIterable(
                  TypeOfMusic.values.toList().rearrange((p0, p1) => p0.name.compareTo(p1.name)),
                  key: (element) => element,
                  value: (element) => element.toString(),
                )..addAll({null: "None"}),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownFilter<BaseFilter>(
                label: "Sort",
                value: clubs.filter,
                onChanged: (BaseFilter? selectedFilter) => clubs.updateFilter(selectedFilter!),
                onClear: () => clubs.updateFilter(BaseFilter.defaultFilter),
                items: Map.fromIterable(
                  BaseFilter.filters,
                  key: (element) => element,
                  value: (element) => element.name,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black,
          height: 24,
          thickness: 1,
        ),
      ],
    );
  }
}
