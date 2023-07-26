import 'package:flutter/cupertino.dart';

extension ListExtension<T> on List<T> {
  List<T> rearrange(int Function(T, T)? compare) {
    sort(compare);
    return this;
  }
}

extension PaddingExtension on List<Widget> {
  List<Widget> addPadding({EdgeInsets padding = const EdgeInsets.all(8)}) => map((widget) => Padding(
        padding: padding,
        child: widget,
      )).toList();
}
