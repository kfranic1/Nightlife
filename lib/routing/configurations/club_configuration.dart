import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/club_page/club_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:provider/provider.dart';

class ClubConfiguration extends RouteConfiguration {
  String info;

  ClubConfiguration(this.info) : super(Routes.club);

  @override
  RouteInformation get routeInformation => RouteInformation(uri: Uri(path: "/${Routes.club}/${Uri.encodeQueryComponent(info)}"));

  @override
  MaterialPage page(BuildContext context) => MaterialPage(child: Builder(
        builder: (context) {
          Club? club = context.read<ClubList>().findClubByName(info);
          if (club == null) return const ErrorPage();
          return Provider.value(
            value: club,
            child: const ClubPage(),
          );
        },
      ));
}
