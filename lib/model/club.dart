import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/enums/day_of_week.dart';
import 'package:nightlife/enums/social_media.dart';
import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/model/review_data.dart';
import 'package:nightlife/model/work_day.dart';
import 'package:nightlife/services/firestore_service.dart';

class Club {
  String id;
  String name;
  String descriptionHr;
  String descriptionEn;
  String location;
  String imageUrl;
  Map<Contact, String?> contacts;
  Map<SocialMedia, String?> socialMedia;
  ReviewData? _reviewData;
  Map<DayOfWeek, WorkDay> workHours;
  int favoriteCount;

  bool get hasReview => _reviewData != null;
  double get score => _reviewData == null ? 0 : _reviewData!.score;
  DateTime? get reviewDate => _reviewData?.date;

  List<TypeOfMusic> get typeOfMusic => workHours.values.map((value) => value.typeOfMusic).toList().expand((element) => element).toSet().toList();

  DocumentReference get clubReference => FirestoreService.clubCollection.doc(id);

  Club({
    required this.id,
    required this.name,
    required this.descriptionHr,
    required this.descriptionEn,
    required this.location,
    required this.contacts,
    required this.socialMedia,
    required ReviewData? reviewData,
    required this.imageUrl,
    required this.workHours,
    required this.favoriteCount,
  }) : _reviewData = reviewData;

  // Convert a Club object into a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'descriptionHr': descriptionHr,
      'descriptionEn': descriptionEn,
      'location': location,
      'contacts': contacts.map((key, value) => MapEntry(key.name, value)),
      'socialMedia': socialMedia.map((key, value) => MapEntry(key.name, value)),
      'reviewData': _reviewData == null ? null : _reviewData!.toMap(),
      'imageUrl': imageUrl,
      'workHours': workHours.map((key, value) => MapEntry(key.name, value.toMap())),
      'favoriteCount': favoriteCount,
    };
  }

  // Convert a Firestore DocumentSnapshot into a Club object
  factory Club.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
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
      socialMedia: (data['socialMedia'] as Map<String, dynamic>).map((key, value) => MapEntry(
            SocialMedia.values.firstWhere((e) => e.name == key),
            value,
          )),
      reviewData: doc['reviewData'] != null ? ReviewData.fromMap(doc['reviewData'] as Map<String, dynamic>) : null,
      imageUrl: data['imageUrl'],
      workHours: (data['workHours'] as Map<dynamic, dynamic>).map((key, value) => MapEntry(
            DayOfWeek.values.firstWhere((element) => element.name == key),
            WorkDay.fromMap(value),
          )),
      favoriteCount: data['favoriteCount'],
    );
  }

  static Future<void> createClub(Club club) async {
    await FirestoreService.clubCollection.add(club.toMap());
  }

  static Future<void> updateClub(Club club) async {
    await FirestoreService.clubCollection.doc(club.id).update(club.toMap());
  }

  static Future<Club> getClub(String clubId) async {
    DocumentSnapshot doc = await FirestoreService.clubCollection.doc(clubId).get();
    return Club.fromDocument(doc);
  }
}
