import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/subpages/login_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class LoginConfiguration extends RouteConfiguration {
  LoginConfiguration() : super(Routes.login);

  @override
  RouteInformation routeInformation = RouteInformation(uri: Uri.parse("/${Routes.profile}/${Routes.login}"));

  @override
  MaterialPage page(BuildContext context) => const MaterialPage(child: LoginPage());
}
