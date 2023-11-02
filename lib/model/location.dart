import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  late String name;
  late LatLng pin;
  late String? info;

  Location({required this.name, required this.pin, this.info});

  factory Location.fromMap(Map<String, dynamic> data) {
    GeoPoint point = data['pin'] as GeoPoint;
    return Location(
      name: data['name'],
      pin: LatLng(point.latitude, point.longitude),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pin": GeoPoint(pin.latitude, pin.longitude),
      'info': info,
    };
  }
}
