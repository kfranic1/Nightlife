import 'package:flutter/material.dart';

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
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
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
                dropdownColor: Colors.black,
                items: items.entries
                    .map((entry) => DropdownMenuItem<T>(
                          value: entry.key,
                          child: Text(
                            entry.value,
                            style: TextStyle(color: Theme.of(context).primaryColor),
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
