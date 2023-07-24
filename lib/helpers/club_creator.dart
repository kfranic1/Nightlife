import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/model/review.dart';

import '../enums/aspect.dart';
import '../enums/contact.dart';
import '../model/club.dart';

class ClubCreator {
  static Future create() async {
    Club club = Club(
        id: "a",
        name: "Club Roko",
        location: "Jarunska ul. 5, Zagreb",
        review: Review(
          date: DateTime.now(),
          aspectReviews: {
            Aspect.atmosphere: AspectReview(description: "ok", score: 1),
            Aspect.customerService: AspectReview(description: "ok", score: 1),
            Aspect.overallImpression: AspectReview(description: "ok", score: 1),
            Aspect.pricesAndDrinkVariety: AspectReview(description: "ok", score: 1),
            Aspect.soundSystemAndLayout: AspectReview(description: "ok", score: 1),
          },
        ),
        contacts: {
          Contact.email: null,
          Contact.facebook: null,
          Contact.instagram: null,
          Contact.phone: null,
          Contact.web: null,
        },
        typeOfMusic: [TypeOfMusic.other],
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/nightlife-zagreb.appspot.com/o/Roko.jpg?alt=media&token=c3a4f90f-142c-4078-982c-d9bfc9635213");
    await Club.createClub(club);
  }
}
