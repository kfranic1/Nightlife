import 'package:flutter/material.dart';
import 'package:nightlife/pages/admin_page/admin_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:nightlife/widgets/app_bar.dart';
import 'package:nightlife/widgets/options_drawer.dart';
import 'package:provider/provider.dart';

import '../helpers/club_list.dart';
import '../model/club.dart';
import '../pages/club_page/club_page.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(builder: (context) {
          return appBar(
            onPressedHome: goToHome,
            onPressedDrawer: () => Scaffold.of(context).openEndDrawer(),
          );
        }),
      ),
      endDrawer: const Drawer(
        width: 250,
        child: OptionsDrawer(),
      ),
      body: Navigator(
        key: navigatorKey,
        pages: [
          if (_configuration.isHomePage) const MaterialPage(child: HomePage()),
          if (_configuration.isOtherPage)
            MaterialPage(
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
  Future<void> setNewRoutePath(Configuration configuration) async {
    _configuration = configuration;
    notifyListeners();
  }

  @override
  void goToHome() => setNewRoutePath(Configuration.home());

  @override
  void goToClub(Map<String, String> params) => setNewRoutePath(Configuration.otherPage(Routes.club, params));
}
