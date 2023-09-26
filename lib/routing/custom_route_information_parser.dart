import 'package:flutter/material.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) return Configuration.home();
    if (uri.pathSegments[0] == Routes.admin) return Configuration.admin();
    if (uri.pathSegments[0] == Routes.club && uri.pathSegments.length > 1) {
      String decodedInfo = Uri.decodeQueryComponent(uri.pathSegments[1]);
      return Configuration.club(decodedInfo);
    }
    return Configuration.home();
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse('/'));
    if (configuration.isAdmin) return RouteInformation(uri: Uri.parse("/${Routes.admin}"));
    if (configuration.isClub) {
      String encodedInfo = Uri.encodeQueryComponent(configuration.info!);
      return RouteInformation(uri: Uri(path: "/${Routes.club}/$encodedInfo"));
    }
    return RouteInformation(uri: Uri.parse('/'));
  }
}
