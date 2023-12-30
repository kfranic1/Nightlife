import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_text_field.dart';
import 'package:nightlife/model/club.dart';

class ClubEditLocation extends StatelessWidget {
  const ClubEditLocation({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClubTextField(
          labelText: 'Address',
          initialValue: club.location.name,
          onChanged: (value) => club.location.name = value,
          validate: true,
          icon: const Icon(Icons.location_pin),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add_location_alt),
            ),
            Expanded(
              child: ClubTextField(
                labelText: 'Latitude',
                initialValue: club.location.pin.latitude.toString(),
                onChanged: (value) => club.location.setLatitude(double.tryParse(value) ?? 0),
                validate: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a latitude';
                  final double? lat = double.tryParse(value);
                  if (lat == null || lat < -90 || lat > 90) return 'Please enter a valid latitude (-90 to 90)';
                  return null;
                },
              ),
            ),
            Expanded(
              child: ClubTextField(
                labelText: 'Longitude',
                initialValue: club.location.pin.longitude.toString(),
                onChanged: (value) => club.location.setLongitude(double.tryParse(value) ?? 0),
                validate: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a longitude';
                  final double? lng = double.tryParse(value);
                  if (lng == null || lng < -180 || lng > 180) return 'Please enter a valid longitude (-180 to 180)';
                  return null;
                },
              ),
            ),
          ],
        ),
        ClubTextField(
          labelText: 'Google Maps URL',
          initialValue: club.location.info,
          onChanged: (value) => club.location.info = value,
          validate: true,
          icon: const Icon(Icons.link),
        ),
      ],
    );
  }
}
