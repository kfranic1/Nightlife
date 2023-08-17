import '../helpers/constants.dart';
import '../model/review.dart';

extension ReviewExtension on Review? {
  String get reviewDateDescription {
    if (this == null) return "Not reviewed";
    return "Review date - ${ddMMyyyyFormater.format(this!.date)}";
  }
}
