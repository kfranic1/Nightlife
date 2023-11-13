import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/routing/configurations/admin_configuration.dart';
import 'package:nightlife/routing/configurations/club_configuration.dart';
import 'package:nightlife/routing/configurations/home_configuration.dart';
import 'package:nightlife/routing/configurations/login_configuration.dart';
import 'package:nightlife/routing/configurations/profile_configuration.dart';
import 'package:nightlife/routing/configurations/signup_configuration.dart';
import 'package:nightlife/routing/route_configuraiton.dart';
import 'package:nightlife/routing/routes.dart';
import 'package:nightlife/widgets/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:seo/html/seo_controller.dart';
import 'package:seo/html/tree/widget_tree.dart';

class CustomRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration>
    implements Routes {
  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  RouteConfiguration get currentConfiguration => _configurationsStack.last;

  final List<RouteConfiguration> _configurationsStack = [HomeConfiguration()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SeoController(
          enabled: true,
          tree: WidgetTree(context: context),
          child: FutureBuilder(
            future: context.read<ClubList>().setup().then((value) async => await GoogleFonts.pendingFonts([
                  GoogleFonts.baloo2(),
                  GoogleFonts.gochiHand(),
                ])),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
              return Navigator(
                key: navigatorKey,
                pages: [currentConfiguration.page(context)],
                onPopPage: (route, result) {
                  if (!route.didPop(result)) return false;
                  if (_configurationsStack.length > 1) _configurationsStack.removeLast();
                  notifyListeners();
                  return true;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    _configurationsStack.add(configuration);
    notifyListeners();
  }

  @override
  void goToHome() => setNewRoutePath(HomeConfiguration());

  @override
  void goToClub(String clubName) => setNewRoutePath(ClubConfiguration(clubName));

  @override
  void goToAdmin(String clubName) => setNewRoutePath(AdminConfiguration(clubName));

  @override
  void goToProfile() => setNewRoutePath(ProfileConfiguration());

  @override
  void goToLogin() => setNewRoutePath(LoginConfiguration());

  @override
  void goToSignup() => setNewRoutePath(SignupConfiguration());

  void goBack() {
    html.window.history.back();
    _configurationsStack.removeLast();
  }
}
