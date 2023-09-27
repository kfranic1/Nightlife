class ReviewData {
  final String reviewId;
  final double score;
  final DateTime date;

  ReviewData(this.reviewId, this.score, this.date);

  factory ReviewData.fromMap(Map<String, dynamic> data) {
    return ReviewData(
      data['reviewId'],
      data['score'],
      DateTime.fromMillisecondsSinceEpoch(data['date'].seconds * 1000),
    );
  }

  Map<String, dynamic> toMap() {
    return {"reviewId": reviewId, "date": date, "score": score};
  }
}
