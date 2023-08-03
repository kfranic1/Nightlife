import '../enums/aspect.dart';
import 'aspect_review.dart';

class Review {
  DateTime date = DateTime.now();
  Map<Aspect, AspectReview> aspectReviews = {for (var element in Aspect.values) element: AspectReview(description: '', score: 0)};

  double get score => aspectReviews.values.fold<double>(0, (previousValue, element) => previousValue + element.score) / Aspect.values.length;

  Review.empty();
  Review.from(Review review) {
    date = review.date;
    aspectReviews = {for (var entry in review.aspectReviews.entries) entry.key: AspectReview(score: entry.value.score, description: entry.value.description)};
  }

  Review({required this.date, required this.aspectReviews});

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "aspectReviews": aspectReviews.map(
        (key, value) => MapEntry(
          key.name,
          value.toMap(),
        ),
      ),
    };
  }

  factory Review.fromMap(Map<dynamic, dynamic> data) {
    return Review(
      date: DateTime.fromMillisecondsSinceEpoch(data['date'].seconds * 1000),
      aspectReviews: (data['aspectReviews'] as Map<dynamic, dynamic>).map(
        (key, value) => MapEntry(Aspect.values.firstWhere((element) => element.name == key), AspectReview.fromMap(value)),
      ),
    );
  }

  @override
  String toString() {
    return "Review from $date.\n$aspectReviews";
  }

  bool isEqual(Review other) => aspectReviews.entries.every((element) => element.value.isEqual(other.aspectReviews[element.key]!));
}
