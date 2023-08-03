import 'package:nightlife/enums/type_of_music.dart';

class WorkDay {
  String hours = '';
  List<TypeOfMusic> typeOfMusic = [];

  bool get open => hours.isNotEmpty;

  WorkDay({
    required this.hours,
    required this.typeOfMusic,
  });

  Map<String, dynamic> toMap() {
    return {
      "hours": hours,
      'typeOfMusic': typeOfMusic.map((e) => e.name),
    };
  }
}
