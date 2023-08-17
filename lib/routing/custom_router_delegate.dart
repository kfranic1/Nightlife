import 'package:flutter/material.dart';
import 'package:nightlife/pages/admin_page/admin_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:nightlife/widgets/app_bar.dart';
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
      appBar: appBar(onPressed: goToHome),
      body: Navigator(
        key: navigatorKey,
        pages: [
          if (_configuration.isHomePage)
            MaterialPage(
              key: ValueKey(_configuration.path),
              child: const HomePage(),
            ),
          if (_configuration.isOtherPage)
            MaterialPage(
              key: ValueKey(_configuration.path),
              child: Builder(builder: (context) {
                switch (_configuration.path) {
                  case Routes.club:
                    if (_configuration.pathParams == null || !_configuration.pathParams!.containsKey('name')) return const ErrorPage();
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
  Future<void> setNewRoutePath(Configuration configuration) async => _configuration = configuration;

  @override
  void goToHome() => _updateRoute(Configuration.home());

  @override
  void goToClub(Map<String, String> params) => _updateRoute(Configuration.otherPage(Routes.club, params));

  void _updateRoute(Configuration configuration) {
    setNewRoutePath(configuration);
    notifyListeners();
  }
}
