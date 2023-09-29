import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/model/review_data.dart';
import 'package:nightlife/services/firestore_service.dart';

import '../enums/aspect.dart';
import 'aspect_review.dart';

class Review {
  String clubId;
  DateTime date = DateTime.now();
  Map<Aspect, AspectReview> aspectReviews = {for (var element in Aspect.values) element: AspectReview(descriptionHr: '', descriptionEn: '', score: 0)};

  double get score => aspectReviews.values.fold<double>(0, (previousValue, element) => previousValue + element.score) / Aspect.values.length;

  Review.empty(this.clubId);
  Review.from(Review review)
      : clubId = review.clubId,
        date = review.date,
        aspectReviews = {
          for (var entry in review.aspectReviews.entries)
            entry.key: AspectReview(score: entry.value.score, descriptionHr: entry.value.descriptionHr, descriptionEn: entry.value.descriptionEn)
        };

  Review(this.clubId, {required this.date, required this.aspectReviews});

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

  factory Review.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      doc.id,
      date: DateTime.fromMillisecondsSinceEpoch(data['date'].seconds * 1000),
      aspectReviews: (data['aspectReviews'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(Aspect.values.firstWhere((element) => element.name == key), AspectReview.fromMap(value)),
      ),
    );
  }

  Future<void> setReview() async {
    await FirestoreService.reviewCollection.doc(clubId).set(toMap());
    await FirestoreService.clubCollection.doc(clubId).update({'reviewData': ReviewData(score, date).toMap()});
  }

  static Future<Review> getReview(String reviewId) async {
    //Consider caching
    DocumentSnapshot doc = await FirestoreService.reviewCollection.doc(reviewId).get();
    return Review.fromDocument(doc);
  }
}
