import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/day_of_week.dart';
import 'package:nightlife/firestore/firestore_service.dart';
import 'package:nightlife/model/work_day.dart';

import '../enums/contact.dart';
import '../enums/type_of_music.dart';
import 'review.dart';

class Club {
  String id;
  String name;
  String descriptionHr;
  String descriptionEn;
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
    required this.descriptionHr,
    required this.descriptionEn,
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
      'descriptionHr': descriptionHr,
      'descriptionEn': descriptionEn,
      'location': location,
      'contacts': contacts.map((key, value) => MapEntry(key.name, value)),
      'review': review == null ? null : review!.toMap(),
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
      descriptionHr: data['descriptionHr'],
      descriptionEn: data['descriptionEn'],
      location: data['location'],
      contacts: (data['contacts'] as Map<String, dynamic>).map((key, value) => MapEntry(
            Contact.values.firstWhere((e) => e.name == key),
            value,
          )),
      review: reviewData == null ? null : Review.fromMap(reviewData),
      imageUrl: data['imageUrl'],
      workHours: (data['workHours'] as Map<dynamic, dynamic>).map((key, value) => MapEntry(
            DayOfWeek.values.firstWhere((element) => element.name == key),
            WorkDay.fromMap(value),
          )),
    );
  }

  Future<void> updateReview(Review? review) async {
    this.review = review;
    await FirestoreService.clubsCollection.doc(id).update({'review': review?.toMap()});
  }

  @override
  String toString() {
    return "$name - $id\n$review";
  }

  // Create a club in Firestore
  static Future<void> createClub(Club club) async {
    await FirestoreService.clubsCollection.add(club.toMap());
  }

  static Future<void> updateClub(Club club) async {
    await FirestoreService.clubsCollection.doc(club.id).update(club.toMap());
  }

  // Retrieve a club from Firestore by ID
  static Future<Club> getClub(String clubId) async {
    DocumentSnapshot doc = await FirestoreService.clubsCollection.doc(clubId).get();
    return Club.fromDocument(doc);
  }
}
