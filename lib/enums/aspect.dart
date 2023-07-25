enum Aspect {
  atmosphere,
  pricesAndDrinkVariety,
  soundSystemAndLayout,
  customerService,
  overallImpression;

  @override
  String toString() {
    switch (this) {
      case Aspect.atmosphere:
        return "Atmosphere";
      case Aspect.pricesAndDrinkVariety:
        return "Prices And Drink Variety";
      case Aspect.soundSystemAndLayout:
        return "Sound System And Layout";
      case Aspect.customerService:
        return "Customer Service";
      case Aspect.overallImpression:
        return "Overall Impression";
    }
  }
}
