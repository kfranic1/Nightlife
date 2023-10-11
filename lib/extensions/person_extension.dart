import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';

extension PersonExtension on Person {
  Future<void> handleFavourite(Club club) async {
    final bool addingToFavourites = !favourites.contains(club.id);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      if (addingToFavourites) {
        favourites.add(club.id);
        transaction.update(personReference, {"favourites": favourites});
        transaction.update(club.clubReference, {'favoriteCount': FieldValue.increment(1)});
      } else {
        favourites.remove(club.id);
        transaction.update(personReference, {"favourites": favourites});
        transaction.update(club.clubReference, {'favoriteCount': FieldValue.increment(-1)});
      }
    });
  }
}
