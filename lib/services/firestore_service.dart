import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {
  static Future renameField({required CollectionReference<Map<String, dynamic>> collection, required String oldValueName, required String newValueName}) async {
    for (var doc in (await collection.get()).docs) {
      Map<String, dynamic> data = doc.data();
      if (data.containsKey(oldValueName)) {
        data[newValueName] = data[oldValueName]; // Add the new field with the old value
        data.remove(oldValueName); // Remove the old field
        await collection.doc(doc.id).set(data);
      }
    }
  }

  static Future addField({required CollectionReference<Map<String, dynamic>> collection, required String fieldName, dynamic defaultValue}) async {
    for (var doc in (await collection.get()).docs) {
      collection.doc(doc.id).update({fieldName: defaultValue});
    }
  }

  static Future removeField({required CollectionReference<Map<String, dynamic>> collection, required String fieldName}) async {
    for (var doc in (await collection.get()).docs) {
      Map<String, dynamic> data = doc.data();
      if (data.containsKey(fieldName)) {
        data.remove(fieldName);
        await collection.doc(doc.id).set(data);
      }
    }
  }
}
