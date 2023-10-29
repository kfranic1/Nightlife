import 'package:flutter/material.dart';
import 'package:nightlife/pages/google_maps_page/google_maps_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

class MapsConfiguration extends RouteConfiguration {
  MapsConfiguration() : super(null);

  @override
  RouteInformation routeInformation = RouteInformation(uri: Uri.parse("/${Routes.maps}"));

  @override
  MaterialPage page(BuildContext context) => const MaterialPage(child: GoogleMapsPage());
}
