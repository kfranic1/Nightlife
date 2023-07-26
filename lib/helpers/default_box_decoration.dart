import 'package:flutter/material.dart';

class DefaultBoxDecoration extends BoxDecoration {
  DefaultBoxDecoration()
      : super(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        );
}
