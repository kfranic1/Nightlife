import 'package:nightlife/helpers/constants.dart';
import 'package:nightlife/model/review.dart';

extension ReviewExtension on Review? {
  String get reviewDateDescription {
    if (this == null) return "Not reviewed";
    return "Review date - ${ddMMyyyyFormater.format(this!.date)}";
  }
}
