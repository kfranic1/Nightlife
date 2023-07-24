enum TypeOfMusic {
  balkanRock,
  trash,
  balkaton,
  narodno,
  house,
  techhouse,
  hiphop,
  trap,
  rnb,
  other;

  @override
  String toString() {
    switch (this) {
      case TypeOfMusic.trash:
        return "Trash";
      case TypeOfMusic.balkaton:
        return "Balkaton";
      case TypeOfMusic.narodno:
        return "Narodno";
      case TypeOfMusic.house:
        return "House";
      case TypeOfMusic.techhouse:
        return "Tech house";
      case TypeOfMusic.hiphop:
        return "Hip-hop";
      case TypeOfMusic.trap:
        return "Trap";
      case TypeOfMusic.rnb:
        return "RnB";
      case TypeOfMusic.balkanRock:
        return "Balkan Rock";
      case TypeOfMusic.other:
        return "Other";
    }
  }
}
