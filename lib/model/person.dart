import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/services/firestore_service.dart';

class Person {
  String id;
  late String name;
  late Role role;
  late Set<String> favourites;

  Person(this.id);

  Person._complete(this.id, {required this.name, required this.role, required this.favourites});

  DocumentReference get personReference => FirestoreService.userCollection.doc(id);

  factory Person.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Person._complete(
      doc.id,
      name: data['name'],
      role: Role.values.firstWhere((element) => element.name == data['role']),
      favourites: Set<String>.from(data['favourites']),
    );
  }

  Future<Person> self() => personReference.get().then((value) => Person.fromDoc(value));

  static Future createPerson(String uid, {required String name, Role role = Role.user}) async {
    await FirestoreService.userCollection.doc(uid).set({'name': name, 'role': role.name, 'favourites': []});
  }

  Future updateName(String newName) async {
    await personReference.update({"name": newName});
  }
}
