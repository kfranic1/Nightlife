enum Aspect {
  atmosphere,
  pricesAndDrinkVariety,
  soundSystemAndLayout,
  customerService,
  overallImpression;

  String get titleHr {
    switch (this) {
      case Aspect.atmosphere:
        return "Atmosfera";
      case Aspect.pricesAndDrinkVariety:
        return "Cijene i izbor pića";
      case Aspect.soundSystemAndLayout:
        return "Razglas i prostor";
      case Aspect.customerService:
        return "Usluga";
      case Aspect.overallImpression:
        return "Ukupni dojam";
    }
  }

  String get titleEn {
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
