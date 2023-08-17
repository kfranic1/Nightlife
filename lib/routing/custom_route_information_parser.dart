import 'package:flutter/material.dart';
import 'package:nightlife/routing/configuraiton.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) return Configuration.home();
    return Configuration.otherPage(Uri.decodeFull(uri.path.substring(1)), uri.queryParameters); // Get the path without the leading "/"
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse('/'));
    if (configuration.isOtherPage) return RouteInformation(uri: Uri(path: '/${configuration.path}', queryParameters: configuration.pathParams));
    return RouteInformation(uri: Uri.parse('/'));
  }
}
