import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/extensions/map_extension.dart';
import 'package:nightlife/extensions/string_extension.dart';
import 'package:nightlife/pages/admin_page/admin_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:provider/provider.dart';

import '../helpers/club_list.dart';
import '../model/club.dart';
import '../pages/clubPage/club_page.dart';
import '../pages/home_page.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration> implements Routes {
  Configuration _configuration = Configuration.home();

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Configuration get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: TextButton(
          style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
          child: const Text(
            'Nightlife Zagreb',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          onPressed: () => goToHome(),
        ),
        actions: [
          TextButton.icon(
            style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
            onPressed: () async => {}, //await launchUrl(Uri.parse("address")),
            label: const Text(
              "Visit our Instagram",
              maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.instagram,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      body: Navigator(
        key: navigatorKey,
        pages: [
          if (_configuration.isHomePage)
            MaterialPage(
              key: ValueKey(_configuration.pathName),
              child: const HomePage(),
            ),
          if (_configuration.isOtherPage)
            MaterialPage(
              key: ValueKey(_configuration.pathName),
              child: Builder(builder: (context) {
                switch (_configuration.pathName?.removeParams()) {
                  case Routes.club:
                    Club? club = context.read<ClubList>().findClubByName(_configuration.pathParams!['name']!);
                    if (club == null) return const ErrorPage();
                    return Provider.value(
                      value: club,
                      child: const ClubPage(),
                    );
                  case Routes.admin:
                    return const AdminPage();
                  default:
                    return const ErrorPage();
                }
              }),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          _configuration = Configuration.home();
          notifyListeners();
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(Configuration configuration) async {
    _configuration = configuration;
  }

  @override
  void goToHome() {
    _updateRoute(Configuration.home());
  }

  @override
  void goToClub(Map<String, String> params) {
    _updateRoute(Configuration.otherPage(Routes.club + params.toStringFromParams()));
  }

  @override
  void goToAdmin(Map<String, String> params) {
    _updateRoute(Configuration.otherPage(Routes.admin + params.toStringFromParams()));
  }

  void _updateRoute(Configuration configuration) {
    setNewRoutePath(configuration);
    notifyListeners();
  }
}
