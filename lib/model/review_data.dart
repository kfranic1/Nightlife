class ReviewData {
  final double score;
  final DateTime date;

  ReviewData(this.score, this.date);

  factory ReviewData.fromMap(Map<String, dynamic> data) {
    return ReviewData(
      data['score'],
      DateTime.fromMillisecondsSinceEpoch(data['date'].seconds * 1000),
    );
  }

  Map<String, dynamic> toMap() {
    return {"date": date, "score": score};
  }
}
