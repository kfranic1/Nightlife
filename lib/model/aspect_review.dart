class AspectReview {
  double score;
  String description;

  AspectReview({
    required this.score,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {"score": score, "description": description};
  }

  factory AspectReview.fromMap(Map<dynamic, dynamic> data) {
    return AspectReview(
      score: data['score'],
      description: data['description'],
    );
  }

  @override
  String toString() {
    return "$score: $description";
  }

  bool isEqual(AspectReview other) => score == other.score && description == other.description;
}
