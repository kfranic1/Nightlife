import 'package:nightlife/enums/type_of_music.dart';
import 'package:nightlife/model/review.dart';

import '../enums/aspect.dart';
import '../model/club.dart';

class ClubCreator {
  static Future create() async {
    Club club = Club(
        id: "a",
        name: "The Secret Club",
        location: "Adresa2",
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
        socialMediaProfiles: {},
        typeOfMusic: [TypeOfMusic.other],
        imageName:
            "https://firebasestorage.googleapis.com/v0/b/nightlife-zagreb.appspot.com/o/original_Best_Paris_Nightclubs-Faust.jpg?alt=media&token=6821e4c8-bbdf-4f83-ad44-e8adc8ea4864");
    await Club.createClub(club);
  }
}
