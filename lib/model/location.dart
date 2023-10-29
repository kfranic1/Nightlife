import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  late final String name;
  late final GeoPoint pin;
  late final String? info;

  Location({required this.name, required this.pin, this.info});

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      name: data['name'],
      pin: data['pin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pin": pin,
      'info': info,
    };
  }
}
