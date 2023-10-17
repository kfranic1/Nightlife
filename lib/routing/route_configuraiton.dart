import 'package:flutter/material.dart';

abstract class RouteConfiguration {
  final String? path;

  RouteConfiguration(this.path);

  RouteInformation get routeInformation;

  MaterialPage page(BuildContext context);
}
