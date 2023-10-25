import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/helpers/collections_list.dart';
import 'package:nightlife/model/person.dart';

extension PersonExtension on Person {
  Future<void> handleFavourite(String clubId) async {
    final bool addingToFavourites = !favourites.contains(clubId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        if (addingToFavourites) {
          transaction.update(CollectionList.userCollection.doc(id), {
            "favourites": FieldValue.arrayUnion([clubId])
          });
          transaction.update(CollectionList.clubCollection.doc(clubId), {'favoriteCount': FieldValue.increment(1)});
        } else {
          transaction.update(CollectionList.userCollection.doc(id), {
            "favourites": FieldValue.arrayRemove([clubId])
          });
          transaction.update(CollectionList.clubCollection.doc(clubId), {'favoriteCount': FieldValue.increment(-1)});
        }
      });

      if (addingToFavourites) {
        favourites.add(clubId);
      } else {
        favourites.remove(clubId);
      }
    } catch (e) {
      print("Transaction failed: $e");
    }
  }
}
