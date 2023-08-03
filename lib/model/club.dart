import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/day_of_week.dart';
import 'package:nightlife/model/work_day.dart';

import '../enums/aspect.dart';
import '../enums/contact.dart';
import '../enums/type_of_music.dart';
import 'review.dart';

class Club {
  String id;
  String name;
  String description;
  String location;
  String imageUrl;
  Map<Contact, String?> contacts;
  Review? review;
  Map<DayOfWeek, WorkDay> workHours;

  double get score => review == null ? 0 : review!.score;
  List<TypeOfMusic> get typeOfMusic => workHours.values.map((value) => value.typeOfMusic).toList().expand((element) => element).toSet().toList();

  Club({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.contacts,
    required this.review,
    required this.imageUrl,
    required this.workHours,
  });

  // Convert a Club object into a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'contacts': contacts.map((key, value) => MapEntry(key.name, value)),
      'review': review == null
          ? null
          : {
              'date': review!.date,
              'aspectReviews': review!.aspectReviews.map((key, value) => MapEntry(key.name, {'score': value.score, 'description': value.description})),
            },
      'imageUrl': imageUrl,
      'workHours': workHours.map((key, value) => MapEntry(key.name, value.toMap())),
    };
  }

  // Convert a Firestore DocumentSnapshot into a Club object
  factory Club.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Map<String, dynamic>? reviewData = data['review'];
    return Club(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        location: data['location'],
        contacts: (data['contacts'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            Contact.values.firstWhere((e) => e.name == key),
            value,
          ),
        ),
        review: reviewData == null
            ? null
            : Review(
                date: DateTime.fromMillisecondsSinceEpoch(reviewData['date'].seconds * 1000),
                aspectReviews: (reviewData['aspectReviews'] as Map<dynamic, dynamic>).map(
                  (key, value) => MapEntry(
                    Aspect.values.firstWhere((element) => element.name == key),
                    AspectReview(
                      score: value['score'],
                      description: value['description'],
                    ),
                  ),
                ),
              ),
        imageUrl: data['imageUrl'],
        workHours: (data['workHours'] as Map<dynamic, dynamic>).map((key, value) => MapEntry(
              DayOfWeek.values.firstWhere((element) => element.name == key),
              WorkDay(
                hours: value['hours'],
                typeOfMusic: (value['typeOfMusic'] as List<dynamic>).map((type) => TypeOfMusic.values.firstWhere((e) => e.name == type)).toList(),
              ),
            )));
  }

  Future<void> updateReview(Review review) async {
    this.review = review;
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    await clubsCollection.doc(id).update({
      'review': {
        'date': review.date,
        'aspectReviews': review.aspectReviews.map((key, value) => MapEntry(key.name, {
              'score': value.score,
              'description': value.description,
            })),
      }
    });
  }

  @override
  String toString() {
    return "$name - $id\n$review";
  }

  // Create a club in Firestore
  static Future<void> createClub(Club club) async {
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    await clubsCollection.add(club.toMap());
  }

  static Future<void> updateClub(Club club) async {
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    await clubsCollection.doc(club.id).update(club.toMap());
  }

  // Retrieve a club from Firestore by ID
  static Future<Club> getClub(String clubId) async {
    final clubsCollection = FirebaseFirestore.instance.collection('clubs');
    DocumentSnapshot doc = await clubsCollection.doc(clubId).get();
    return Club.fromDocument(doc);
  }
}
