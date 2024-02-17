import 'package:flutter/material.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/services/club_data_service.dart';
import 'package:nightlife/widgets/dropdown_filter.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late final TextEditingController _searchController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: context.read<ClubDataService>().filterText);
    _searchController.addListener(() => context.read<ClubDataService>().updateText(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ClubDataService clubDataService = context.watch<ClubDataService>();
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: const ListTileThemeData(
          dense: true, // Reduces the default vertical padding.
          contentPadding: EdgeInsets.symmetric(vertical: 0.0), // Set your padding if needed.
          horizontalTitleGap: 0,
        ),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            const Text("Filter"),
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 18,
            ),
          ],
        ),
        trailing: clubDataService.isFiltered
            ? TextButton(
                onPressed: () {
                  clubDataService.clearFiler();
                  _searchController.clear();
                },
                child: const Text("Clear filters"),
              )
            : const SizedBox(),
        onExpansionChanged: (bool expanded) => setState(() => _isExpanded = expanded),
        children: [
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'SEARCH',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          DropdownFilter<TypeOfMusic?>(
            label: "GENRE",
            value: clubDataService.typeOfMusic,
            onChanged: (TypeOfMusic? type) => clubDataService.updateTypeOfMusic(type),
            onClear: () => clubDataService.updateTypeOfMusic(null),
            items: Map.fromIterable(
              TypeOfMusic.values.toList().rearrange((p0, p1) => p0.name.compareTo(p1.name)),
              key: (element) => element,
              value: (element) => element.toString(),
            )..addAll({null: "None"}),
          ),
          const SizedBox(height: 8),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 12.0, right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white),
            ),
            child: InkWell(
              onTap: () => clubDataService.updateShowOpenTonightOnly(),
              child: Row(
                children: [
                  const Text("OPEN TONIGHT"),
                  const Expanded(child: SizedBox()),
                  Checkbox(
                    value: clubDataService.showOpenTonightOnly,
                    onChanged: (bool? value) => clubDataService.updateShowOpenTonightOnly(),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
            height: 32,
          ),
        ],
      ),
    );
  }
}
