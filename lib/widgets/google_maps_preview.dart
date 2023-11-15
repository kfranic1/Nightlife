import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/marker/custom_marker.dart';
import 'package:provider/provider.dart';

class GoogleMapsPreview extends StatelessWidget {
  const GoogleMapsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final club = context.read<Club>();
    double height = 150;
    double width = min(400, MediaQuery.of(context).size.width - 16);
    double markerRadius = 25;
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          GoogleMap(
            padding: const EdgeInsets.only(bottom: 100.0),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: club.location.pin,
              zoom: 14.8,
            ),
            onMapCreated: (GoogleMapController controller) async => await controller.setMapStyle(await rootBundle.loadString('assets/maps/map_style.txt')),
            zoomControlsEnabled: false,
            scrollGesturesEnabled: false,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
          ),
          Positioned(
            left: width / 2 - markerRadius,
            top: height / 2 - 2.8 * markerRadius,
            child: CustomMarker(
              imageUrl: club.imageUrl,
              radius: markerRadius,
            ),
          ),
        ],
      ),
    );
  }
}
