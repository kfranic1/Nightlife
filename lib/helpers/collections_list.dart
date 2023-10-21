import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CollectionList {
  static CollectionReference<Map<String, dynamic>> clubCollection = FirebaseFirestore.instance.collection("clubs");
  static CollectionReference<Map<String, dynamic>> reviewCollection = FirebaseFirestore.instance.collection("reviews");
  static CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection("users");
  static CollectionReference<Map<String, dynamic>> administrationCollection = FirebaseFirestore.instance.collection("administration");
}
