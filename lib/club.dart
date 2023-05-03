import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'enums/social_media.dart';
import 'enums/type_of_music.dart';

class Club {
  String id;
  String name;
  String location;
  TypeOfMusic typeOfMusic;
  Map<SocialMedia, String> socialMediaProfiles;
  List<double> aspectScores;

  double get score => aspectScores.last;

  Color get color => (score <= 5) ? Color.lerp(Colors.red, Colors.yellow, score / 5)! : Color.lerp(Colors.yellow, Colors.green, (score - 5) / 5)!;

  Club({
    required this.id,
    required this.name,
    required this.location,
    required this.typeOfMusic,
    required this.socialMediaProfiles,
    required this.aspectScores,
  });

  // Convert a Club object into a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'typeOfMusic': typeOfMusic.index,
      'socialMediaProfiles': socialMediaProfiles.map((key, value) => MapEntry(key.toString(), value)),
      'aspectScores': aspectScores,
    };
  }

  // Convert a Firestore DocumentSnapshot into a Club object
  factory Club.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Club(
      id: doc.id,
      name: data['name'],
      location: data['location'],
      typeOfMusic: TypeOfMusic.values[data['typeOfMusic']],
      socialMediaProfiles: (data['socialMediaProfiles'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          SocialMedia.values.firstWhere((e) => e.toString() == key),
          value,
        ),
      ),
      aspectScores: List<double>.from(data['aspectScores']),
    );
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
}
