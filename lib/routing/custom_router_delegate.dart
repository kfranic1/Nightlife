import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/admin_page/admin_page.dart';
import 'package:nightlife/pages/club_page/club_page.dart';
import 'package:nightlife/pages/error_page.dart';
import 'package:nightlife/pages/home_page.dart';
import 'package:nightlife/pages/profile_page/profile_page.dart';
import 'package:nightlife/pages/profile_page/subpages/login_page.dart';
import 'package:nightlife/pages/profile_page/subpages/signup_page.dart';
import 'package:nightlife/routing/configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:provider/provider.dart';

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
        else if (_configuration.isProfile)
          const MaterialPage(child: ProfilePage())
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
        else if (_configuration.isLogin)
          const MaterialPage(child: LoginPage())
        else if (_configuration.isSignup)
          const MaterialPage(child: SignUpPage())
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

  @override
  void goToProfile() => setNewRoutePath(Configuration.other(Routes.profile));

  @override
  void goToLogin() => setNewRoutePath(Configuration.login());

  @override
  void goToSignup() => setNewRoutePath(Configuration.signup());

  void goBack() {
    html.window.history.back();
    _configurationsStack.removeLast();
  }

  void handleLogin() {
    while (_configurationsStack.last.isLogin || _configurationsStack.last.isSignup) goBack();
    goToProfile();
  }
}
