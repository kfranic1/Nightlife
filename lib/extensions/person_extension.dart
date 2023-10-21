import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/helpers/collections_list.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';

extension PersonExtension on Person {
  Future<void> handleFavourite(Club club) async {
    final bool addingToFavourites = !favourites.contains(club.id);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        if (addingToFavourites) {
          transaction.update(CollectionList.userCollection.doc(id), {
            "favourites": FieldValue.arrayUnion([club.id])
          });
          transaction.update(CollectionList.clubCollection.doc(id), {'favoriteCount': FieldValue.increment(1)});
        } else {
          transaction.update(CollectionList.userCollection.doc(id), {
            "favourites": FieldValue.arrayRemove([club.id])
          });
          transaction.update(CollectionList.clubCollection.doc(id), {'favoriteCount': FieldValue.increment(-1)});
        }
      });

      if (addingToFavourites) {
        favourites.add(club.id);
      } else {
        favourites.remove(club.id);
      }
    } catch (e) {
      print("Transaction failed: $e");
    }
  }
}
