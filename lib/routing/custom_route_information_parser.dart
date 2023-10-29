import 'package:flutter/material.dart';
import 'package:nightlife/routing/configurations/admin_configuration.dart';
import 'package:nightlife/routing/configurations/club_configuration.dart';
import 'package:nightlife/routing/configurations/home_configuration.dart';
import 'package:nightlife/routing/configurations/login_configuration.dart';
import 'package:nightlife/routing/configurations/maps_configuration.dart';
import 'package:nightlife/routing/configurations/profile_configuration.dart';
import 'package:nightlife/routing/configurations/signup_configuration.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class CustomRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) return HomeConfiguration();
    if (uri.pathSegments[0] == Routes.maps) return MapsConfiguration();
    if (uri.pathSegments[0] == Routes.admin && uri.pathSegments.length > 1) {
      String decodedInfo = Uri.decodeQueryComponent(uri.pathSegments[1]);
      return AdminConfiguration(decodedInfo);
    }
    if (uri.pathSegments[0] == Routes.profile) {
      if (uri.pathSegments.length == 1) return ProfileConfiguration();
      if (uri.pathSegments[1] == Routes.login) return LoginConfiguration();
      if (uri.pathSegments[1] == Routes.signup) return SignupConfiguration();
    }
    if (uri.pathSegments[0] == Routes.club && uri.pathSegments.length > 1) {
      String decodedInfo = Uri.decodeQueryComponent(uri.pathSegments[1]);
      return ClubConfiguration(decodedInfo);
    }
    return HomeConfiguration();
  }

  @override
  RouteInformation restoreRouteInformation(RouteConfiguration configuration) => configuration.routeInformation;
}
