import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/helpers/collections_list.dart';
import 'package:nightlife/model/admin_data.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/model/user_info.dart';

class Administration {
  late final String administrationId;
  late final Map<String, UserInfo> members;

  Administration(this.administrationId);

  Stream<Administration> get self => CollectionList.administrationCollection.doc(administrationId).snapshots().map((doc) => Administration.fromDocument(doc));

  Administration.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    administrationId = doc.id;
    members = (data['members'] as Map<String, dynamic>).map((key, value) => MapEntry(key, UserInfo.fromMap(value)));
  }

  static Future<Administration> getAdministration(String administrationId) async {
    return Administration.fromDocument(await CollectionList.administrationCollection.doc(administrationId).get());
  }

  Future<void> addMember(Person person, Club club, Role role) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(CollectionList.administrationCollection.doc(administrationId), {
        "members.${person.id}": UserInfo(
          username: person.name,
          role: role,
        ).toMap()
      });

      transaction.update(CollectionList.userCollection.doc(person.id), {
        'adminData': AdminData(
          role: role,
          clubId: club.id,
          clubName: club.name,
        ).toMap()
      });
    });
  }

  Future<void> removeMember(String userId) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(CollectionList.administrationCollection.doc(administrationId), {"members.$userId": FieldValue.delete()});
      transaction.update(CollectionList.userCollection.doc(userId), {'adminData': null});
    });
  }
}
