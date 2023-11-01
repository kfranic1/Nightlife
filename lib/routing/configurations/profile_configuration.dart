import 'package:flutter/material.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class ProfileConfiguration extends RouteConfiguration {
  ProfileConfiguration() : super(Routes.profile);

  @override
  RouteInformation routeInformation = RouteInformation(uri: Uri.parse("/${Routes.profile}"));

  @override
  MaterialPage page(BuildContext context) => const MaterialPage(child: ErrorPage());
}
