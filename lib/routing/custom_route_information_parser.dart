import 'package:flutter/material.dart';
import 'package:nightlife/routing/configuraiton.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    String location = routeInformation.location!;
    if (Uri.parse(location).pathSegments.isEmpty) return Configuration.home();
    return Configuration.otherPage(Uri.decodeFull(location).substring(1));
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return const RouteInformation(location: '/');
    if (configuration.isOtherPage) return RouteInformation(location: '/${configuration.pathName}');
    return const RouteInformation(location: '/');
  }
}
