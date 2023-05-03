import 'package:flutter/material.dart';
import 'package:nightlife/extensions/map_extension.dart';
import 'package:nightlife/extensions/string_extension.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';

import '../pages/club_page.dart';
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
                    return const ClubPage();
                  default:
                    return const HomePage();
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
    setNewRoutePath(Configuration.home());
    notifyListeners();
  }

  @override
  void goToClub(Map<String, String> params) {
    setNewRoutePath(Configuration.otherPage(Routes.club + params.toStringFromParams()));
    notifyListeners();
  }
}
