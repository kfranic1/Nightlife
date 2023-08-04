import 'package:flutter/material.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/list_extension.dart';
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
    _searchController.text = context.read<ClubList>().filterText;
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
            onChanged: (value) => clubs.updateText(value),
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            DropdownFilter<TypeOfMusic?>(
              label: "Genre",
              value: clubs.typeOfMusic,
              onChanged: (TypeOfMusic? type) => clubs.updateTypeOfMusic(type),
              items: Map.fromIterable(
                TypeOfMusic.values.toList().rearrange((p0, p1) => p0.name.compareTo(p1.name)),
                key: (element) => element,
                value: (element) => element.toString(),
              )..addAll({null: "None"}),
            ),
            const SizedBox(width: 8),
            DropdownFilter<BaseFilter>(
              label: "Sort",
              value: clubs.filter,
              onChanged: (BaseFilter? selectedFilter) => clubs.updateFilter(selectedFilter!),
              items: Map.fromIterable(BaseFilter.filters, key: (element) => element, value: (element) => element.name),
            ),
          ],
        ),
      ],
    );
  }
}

class DropdownFilter<T> extends StatelessWidget {
  const DropdownFilter({
    super.key,
    required this.label,
    required this.onChanged,
    required this.items,
    required this.value,
  });

  final String label;
  final ValueChanged<T?>? onChanged;
  final Map<T, String> items;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 12.0),
        decoration: DefaultBoxDecoration(),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<T?>(
                value: value,
                underline: Container(),
                onChanged: onChanged,
                isExpanded: true,
                items: items.keys
                    .map((key) => DropdownMenuItem<T>(
                          value: key,
                          child: Text(
                            items[key]!,
                            style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
