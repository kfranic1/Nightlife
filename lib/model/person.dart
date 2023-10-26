import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/helpers/collections_list.dart';
import 'package:nightlife/model/admin_data.dart';

class Person {
  String id;
  late String name;
  late AdminData? adminData;
  late Set<String> favourites;

  bool get hasAdminAccess => adminData != null;
  bool get isAdmin => hasAdminAccess && adminData!.role == Role.admin;

  Person(this.id);

  Person._complete(this.id, {required this.name, required this.adminData, required this.favourites});

  factory Person.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Person._complete(
      doc.id,
      name: data['name'],
      favourites: Set<String>.from(data['favourites']),
      adminData: data['adminData'] == null ? null : AdminData.fromMap(data['adminData']),
    );
  }

  Future<Person> self() => CollectionList.userCollection.doc(id).get().then((value) => Person.fromDoc(value));

  static Future createPerson(String uid, {required String name, AdminData? adminData}) async {
    await CollectionList.userCollection.doc(uid).set({
      'name': name,
      'favourites': [],
      "adminData": adminData,
    });
  }

  Future updateName(String newName) async {
    await CollectionList.userCollection.doc(id).update({"name": name = newName});
  }

  static Future<Person?> tryGet(String id) async {
    return await CollectionList.userCollection.doc(id).get().then((value) => !value.exists ? null : Person.fromDoc(value));
  }
}
