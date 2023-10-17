import 'package:flutter/material.dart';
import 'package:nightlife/pages/home_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';

class HomeConfiguration extends RouteConfiguration {
  HomeConfiguration() : super(null);

  @override
  RouteInformation routeInformation = RouteInformation(uri: Uri.parse('/'));

  @override
  MaterialPage page(BuildContext context) => const MaterialPage(child: HomePage());
}
