import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

class DefaultBoxDecoration extends BoxDecoration {
  DefaultBoxDecoration()
      : super(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(8.0),
        );
}
