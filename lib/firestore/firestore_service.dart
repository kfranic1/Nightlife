import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/club.dart';

abstract class FirestoreService {
  static String collection = "clubs";

  static Future<List<Club>> getClubs() async {
    return (await FirebaseFirestore.instance.collection(collection).get().then((value) => value.docs.map((e) => Club.fromDocument((e))))).toList();
  }

  static Future renameField({required String collectionName, required String oldValueName, required String newValueName}) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);

    for (var doc in (await collection.get()).docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey(oldValueName)) {
        data[newValueName] = data[oldValueName]; // Add the new field with the old value
        data.remove(oldValueName); // Remove the old field
        await collection.doc(doc.id).set(data);
      }
    }
  }

  static Future addField({required String collectionName, required String fieldName, required dynamic defaultValue}) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);

    for (var doc in (await collection.get()).docs) {
      collection.doc(doc.id).update({fieldName: defaultValue});
    }
  }

  static Future removeField({required String collectionName, required String fieldName}) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);

    for (var doc in (await collection.get()).docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey(fieldName)) {
        data.remove(fieldName);
        await collection.doc(doc.id).set(data);
      }
    }
  }
}
