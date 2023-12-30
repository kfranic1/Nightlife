import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Location {
  late String name;
  late LatLng pin;
  late String info;

  Location({required this.name, required this.pin, required this.info});

  factory Location.fromMap(Map<String, dynamic> data) {
    GeoPoint point = data['pin'] as GeoPoint;
    return Location(
      name: data['name'],
      pin: LatLng(point.latitude, point.longitude),
      info: data['info'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pin": GeoPoint(pin.latitude, pin.longitude),
      'info': info,
    };
  }

  Future<void> openMap() async {
    if (await canLaunchUrl(Uri.parse(info))) {
      await launchUrl(Uri.parse(info));
    } else {
      throw 'Could not open the map.';
    }
  }

  void setLatitude(double lat) => pin = LatLng(lat, pin.longitude);
  void setLongitude(double lng) => pin = LatLng(pin.latitude, lng);
}
