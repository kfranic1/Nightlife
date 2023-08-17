import '../helpers/constants.dart';
import '../model/club.dart';

extension ClubExtension on Club {
  String get lastReviewDateDescription {
    if (review == null) return "Not reviewed";
    return "Last review - ${ddMMyyyyFormater.format(review!.date)}";
  }
}
