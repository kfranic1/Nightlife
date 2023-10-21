import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/model/admin_data.dart';
import 'package:nightlife/services/firestore_service.dart';

class Person {
  String id;
  late String name;
  late AdminData? adminData;
  late Set<String> favourites;

  bool get hasAdminAccess => adminData != null;
  bool get isAdmin => hasAdminAccess && adminData!.role == Role.admin;

  Person(this.id);

  Person._complete(this.id, {required this.name, required this.adminData, required this.favourites});

  DocumentReference get personReference => FirestoreService.userCollection.doc(id);

  factory Person.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Person._complete(
      doc.id,
      name: data['name'],
      favourites: Set<String>.from(data['favourites']),
      adminData: data['adminData'] == null ? null : AdminData.fromMap(data['adminData']),
    );
  }

  Future<Person> self() => personReference.get().then((value) => Person.fromDoc(value));

  static Future createPerson(String uid, {required String name, AdminData? adminData}) async {
    await FirestoreService.userCollection.doc(uid).set({
      'name': name,
      'favourites': [],
      "adminData": adminData,
    });
  }

  Future updateName(String newName) async {
    await personReference.update({"name": newName});
  }

  static Future<Person?> tryGet(String id) async {
    return await FirestoreService.userCollection.doc(id).get().then((value) => !value.exists ? null : Person.fromDoc(value));
  }
}
