import 'package:flutter/material.dart';
import 'package:nightlife/helpers/decorated_container.dart';

class DropdownFilter<T> extends StatelessWidget {
  const DropdownFilter({
    super.key,
    required this.label,
    required this.onChanged,
    required this.items,
    required this.value,
    required this.onClear,
  });

  final String label;
  final ValueChanged<T?>? onChanged;
  final void Function()? onClear;
  final Map<T, String> items;
  final T value;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
              ),
              child: DropdownButton<T?>(
                value: value,
                underline: Container(),
                onChanged: onChanged,
                isExpanded: true,
                icon: onClear == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: onClear,
                        splashRadius: 20,
                      ),
                items: items.entries
                    .map((entry) => DropdownMenuItem<T>(
                          value: entry.key,
                          child: Text(
                            entry.value,
                            style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
