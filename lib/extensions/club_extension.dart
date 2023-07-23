import 'package:intl/intl.dart';

import '../model/club.dart';

extension ClubExtension on Club {
  String get lastReview {
    if (review == null) return "Not reviewed";
    final formater = DateFormat('dd.MM.yyyy');
    return "Last reivew - ${formater.format(review!.date)}";
  }
}
