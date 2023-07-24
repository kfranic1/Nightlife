import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FieldRename {
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
}
