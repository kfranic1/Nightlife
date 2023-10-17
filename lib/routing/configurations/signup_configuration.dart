import 'package:flutter/material.dart';
import 'package:nightlife/pages/profile_page/subpages/signup_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class SignupConfiguration extends RouteConfiguration {
  SignupConfiguration() : super(Routes.signup);

  @override
  RouteInformation routeInformation = RouteInformation(uri: Uri.parse("/${Routes.profile}/${Routes.signup}"));

  @override
  MaterialPage page(BuildContext context) => const MaterialPage(child: SignUpPage());
}
