import 'package:flutter/material.dart';

class ColumnWithTitle extends StatelessWidget {
  const ColumnWithTitle({super.key, required String title, required List<Widget> children, required double width})
      : _title = title,
        _children = children,
        _width = width;

  final String _title;
  final List<Widget> _children;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          Column(children: _children),
        ],
      ),
    );
  }
}
