import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

class DecoratedContainer extends Container {
  DecoratedContainer({Key? key, Widget? child, EdgeInsetsGeometry? padding}) : super(key: key, child: child, padding: padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
