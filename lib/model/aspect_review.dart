class AspectReview {
  double score;
  String descriptionHr;
  String descriptionEn;

  AspectReview({
    required this.score,
    required this.descriptionHr,
    required this.descriptionEn,
  });

  Map<String, dynamic> toMap() {
    return {
      "score": score,
      "descriptionHr": descriptionHr,
      "descriptionEn": descriptionEn,
    };
  }

  factory AspectReview.fromMap(Map<dynamic, dynamic> data) {
    return AspectReview(
      score: data['score'],
      descriptionHr: data['descriptionHr'],
      descriptionEn: data['descriptionEn'],
    );
  }

  @override
  String toString() {
    return "$score\n$descriptionHr\n$descriptionEn";
  }
}
