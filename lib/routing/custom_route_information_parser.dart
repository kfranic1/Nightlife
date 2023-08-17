import 'package:flutter/material.dart';
import 'package:nightlife/routing/configuraiton.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    String location = routeInformation.uri.path;
    if (Uri.parse(location).pathSegments.isEmpty) return Configuration.home();
    return Configuration.otherPage(Uri.decodeFull(location).substring(1));
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse('/'));
    if (configuration.isOtherPage) return RouteInformation(uri: Uri.parse('/${configuration.pathName}'));
    return RouteInformation(uri: Uri.parse('/'));
  }
}
