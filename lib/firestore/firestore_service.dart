import 'package:cloud_firestore/cloud_firestore.dart';

import '../club.dart';

abstract class FirestoreService {
  static String collection = "clubs";

  static Future<List<Club>> getClubs() async {
    return (await FirebaseFirestore.instance.collection(collection).get().then((value) => value.docs.map((e) => Club.fromDocument((e))))).toList();
  }
}
