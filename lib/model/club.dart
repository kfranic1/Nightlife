import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../enums/aspect.dart';
import '../enums/social_media.dart';
import '../enums/type_of_music.dart';
import 'review.dart';

class Club {
  String id;
  String name;
  String location;
  String imageName;
  List<TypeOfMusic> typeOfMusic;
  Map<SocialMedia, String> socialMediaProfiles;
  Review review;

  double get score => review.score;

  Color get color => (score <= 5) ? Color.lerp(Colors.red, Colors.yellow, score / 5)! : Color.lerp(Colors.yellow, Colors.green, (score - 5) / 5)!;

  Club(
      {required this.id,
      required this.name,
      required this.location,
      required this.typeOfMusic,
      required this.socialMediaProfiles,
      required this.review,
      required this.imageName});

  // Convert a Club object into a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'typeOfMusic': typeOfMusic.map((e) => e.toString()),
      'socialMediaProfiles': socialMediaProfiles.map((key, value) => MapEntry(key.toString(), value)),
      'review': {
        'date': review.date,
        'aspectReviews': review.aspectReviews.map((key, value) => MapEntry(key.toString(), {'score': value.score, 'description': value.description})),
      },
      'imageName': imageName
    };
  }

  // Convert a Firestore DocumentSnapshot into a Club object
  factory Club.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Map<String, dynamic> reviewData = data['review'];
    return Club(
        id: doc.id,
        name: data['name'],
        location: data['location'],
        typeOfMusic: (data['typeOfMusic'] as List<dynamic>).map((type) => TypeOfMusic.values.firstWhere((e) => e.toString() == type)).toList(),
        socialMediaProfiles: (data['socialMediaProfiles'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            SocialMedia.values.firstWhere((e) => e.toString() == key),
            value,
          ),
        ),
        review: Review(
          date: DateTime.fromMillisecondsSinceEpoch(reviewData['date'].seconds * 1000),
          aspectReviews: (reviewData['aspectReviews'] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(
              Aspect.values.firstWhere((element) => element.toString() == key),
              AspectReview(
                score: value['score'],
                description: value['description'],
              ),
            ),
          ),
        ),
        imageName: data['imageName']);
  }

  // Create a club in Firestore
  static Future<void> createClub(Club club) async {
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    await clubsCollection.add(club.toMap());
  }

  // Retrieve a club from Firestore by ID
  static Future<Club> getClub(String clubId) async {
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    DocumentSnapshot doc = await clubsCollection.doc(clubId).get();
    return Club.fromDocument(doc);
  }

  @override
  String toString() {
    return "$name - $id\n$review";
  }
}
