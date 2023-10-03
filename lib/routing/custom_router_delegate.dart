import 'package:flutter/material.dart';
import 'package:nightlife/pages/admin_page/admin_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
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

  final List<Configuration> _configurationsStack = [Configuration.home()];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_configuration.isHomePage)
          const MaterialPage(child: HomePage())
        else if (_configuration.isAdmin)
          const MaterialPage(child: AdminPage())
        else if (_configuration.isClub)
          MaterialPage(child: Builder(
            builder: (context) {
              Club? club = context.read<ClubList>().findClubByName(_configuration.info!);
              if (club == null) return const ErrorPage();
              return Provider.value(
                value: club,
                child: const ClubPage(),
              );
            },
          ))
        else
          const MaterialPage(child: ErrorPage())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_configurationsStack.length > 1) _configurationsStack.removeLast();
        _configuration = _configurationsStack.last;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Configuration configuration) async {
    _configurationsStack.add(configuration);
    _configuration = configuration;
    notifyListeners();
  }

  @override
  void goToHome() => setNewRoutePath(Configuration.home());

  @override
  void goToClub(String clubName) => setNewRoutePath(Configuration.club(clubName));
}
