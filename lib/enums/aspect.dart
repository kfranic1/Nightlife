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
        return "Prices and drink variety";
      case Aspect.soundSystemAndLayout:
        return "Sound system and layout";
      case Aspect.customerService:
        return "Customer service";
      case Aspect.overallImpression:
        return "Overall impression";
    }
  }
}
