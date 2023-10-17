import 'package:flutter/material.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) return Configuration.home();
    if (uri.pathSegments[0] == Routes.admin && uri.pathSegments.length > 1) {
      String decodedInfo = Uri.decodeQueryComponent(uri.pathSegments[1]);
      return Configuration.admin(decodedInfo);
    }
    if (uri.pathSegments[0] == Routes.profile) {
      if (uri.pathSegments.length == 1) return Configuration.profile();
      if (uri.pathSegments[1] == Routes.login) return Configuration.login();
      if (uri.pathSegments[1] == Routes.signup) return Configuration.signup();
    }
    if (uri.pathSegments[0] == Routes.club && uri.pathSegments.length > 1) {
      String decodedInfo = Uri.decodeQueryComponent(uri.pathSegments[1]);
      return Configuration.club(decodedInfo);
    }
    return Configuration.home();
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse('/'));
    if (configuration.isProfile) return RouteInformation(uri: Uri.parse("/${Routes.profile}"));
    if (configuration.isLogin) return RouteInformation(uri: Uri.parse("/${Routes.profile}/${Routes.login}"));
    if (configuration.isSignup) return RouteInformation(uri: Uri.parse("/${Routes.profile}/${Routes.signup}"));
    if (configuration.isAdmin) {
      String encodedInfo = Uri.encodeQueryComponent(configuration.info!);
      return RouteInformation(uri: Uri(path: "/${Routes.admin}/$encodedInfo"));
    }
    if (configuration.isClub) {
      String encodedInfo = Uri.encodeQueryComponent(configuration.info!);
      return RouteInformation(uri: Uri(path: "/${Routes.club}/$encodedInfo"));
    }
    return RouteInformation(uri: Uri.parse('/'));
  }
}
