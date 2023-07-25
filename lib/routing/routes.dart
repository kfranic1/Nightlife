abstract class Routes {
  static const String home = "";
  static const String club = "club";
  static const String admin = "admin";
  static const String review = "review";

  void goToHome() {}
  void goToClub(Map<String, String> params) {}
  void goToAdmin(Map<String, String> params) {}
  void goToReview(Map<String, String> params) {}
}
