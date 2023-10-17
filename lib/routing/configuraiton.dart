import 'package:nightlife/routing/routes.dart';

class Configuration {
  final String? path;
  final String? info;

  Configuration.home()
      : path = null,
        info = null;

  Configuration.profile() : path = Routes.profile, info = null;

  Configuration.club(this.info) : path = Routes.club;

  Configuration.admin(this.info) : path = Routes.admin;

  Configuration.login()
      : path = Routes.login,
        info = null;
  Configuration.signup()
      : path = Routes.signup,
        info = null;

  bool get isHomePage => path == null;
  bool get isAdmin => path == Routes.admin;
  bool get isProfile => path == Routes.profile;
  bool get isClub => path == Routes.club;
  bool get isLogin => path == Routes.login;
  bool get isSignup => path == Routes.signup;
}
