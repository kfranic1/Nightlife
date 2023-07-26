import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/aspect.dart';

class Review {
  DateTime date = DateTime.now();
  Map<Aspect, AspectReview> aspectReviews = {for (var element in Aspect.values) element: AspectReview(description: '', score: 0)};

  double get score => aspectReviews.values.fold<double>(0, (previousValue, element) => previousValue + element.score) / Aspect.values.length;

  final _firestore = FirebaseFirestore.instance;

  Review.empty();
  Review.from(Review review) {
    date = review.date;
    aspectReviews = {for (var entry in review.aspectReviews.entries) entry.key: AspectReview(score: entry.value.score, description: entry.value.description)};
  }

  Review({required this.date, required this.aspectReviews});

  // Get a Review from Firestore
  Future<void> getReviewFromFirestore(String reviewId) async {
    DocumentSnapshot documentSnapshot = await _firestore.collection('reviews').doc(reviewId).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    date = DateTime.fromMillisecondsSinceEpoch(data['date'].seconds * 1000);
    aspectReviews = (data['aspectReviews'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        Aspect.values.firstWhere((e) => e.toString() == 'Aspect.$key'),
        AspectReview(score: value['score'], description: value['description']),
      ),
    );
  }

  // Add a Review to Firestore
  Future<void> addReviewToFirestore() async {
    await _firestore.collection('reviews').add({
      'date': Timestamp.fromDate(date),
      'aspectReviews': aspectReviews.map((key, value) => MapEntry(
            key.toString(),
            {'score': value.score, 'description': value.description},
          )),
    });
  }

  @override
  String toString() {
    return "Review from $date.\n$aspectReviews";
  }

  bool isEqual(Review other) => aspectReviews.entries.every((element) => element.value.isEqual(other.aspectReviews[element.key]!));
}

class AspectReview {
  double score;
  String description;

  AspectReview({
    required this.score,
    required this.description,
  });

  @override
  String toString() {
    return "$score: $description";
  }

  bool isEqual(AspectReview other) => score == other.score && description == other.description;
}
