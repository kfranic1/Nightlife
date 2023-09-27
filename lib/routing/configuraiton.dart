import 'package:nightlife/routing/routes.dart';

class Configuration {
  final String? path;
  final String? info;

  Configuration.home() : path = null, info = null;

  Configuration.other(this.path) : info = null;

  Configuration.club(this.info) : path = Routes.club;

  bool get isHomePage => path == null;
  bool get isAdmin => path == Routes.admin;
  bool get isProfile => path == Routes.profile;
  bool get isClub => path == Routes.club;

}
