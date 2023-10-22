import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/enums/role.dart';
import 'package:nightlife/helpers/collections_list.dart';
import 'package:nightlife/model/admin_data.dart';

class Administration {
  late final String administrationId;
  late final List<String> members;

  Administration(this.administrationId);

  Stream<Administration> get self => CollectionList.administrationCollection.doc(administrationId).snapshots().map((doc) => Administration.fromDocument(doc));

  Administration.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    administrationId = doc.id;
    members = List<String>.from(data['members']);
  }

  Future<void> addMember({required String userId, required String clubId, required String clubName, required Role role}) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(CollectionList.administrationCollection.doc(administrationId), {
        "members": FieldValue.arrayUnion([userId])
      });

      transaction.update(CollectionList.userCollection.doc(userId), {
        'adminData': AdminData(
          role: role,
          clubId: clubId,
          clubName: clubName,
        ).toMap()
      });
    });
  }

  Future<void> removeMember(String userId) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(CollectionList.administrationCollection.doc(administrationId), {
        "members": FieldValue.arrayRemove([userId])
      });
      transaction.update(CollectionList.userCollection.doc(userId), {'adminData': null});
    });
  }
}
