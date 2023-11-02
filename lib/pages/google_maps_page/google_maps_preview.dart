import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/google_maps_page/marker/custom_marker.dart';
import 'package:provider/provider.dart';

class GoogleMapsPreview extends StatefulWidget {
  const GoogleMapsPreview({super.key});

  @override
  State<GoogleMapsPreview> createState() => _GoogleMapsPreviewState();
}

class _GoogleMapsPreviewState extends State<GoogleMapsPreview> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final club = context.read<Club>();
    double height = 150;
    double width = 400;
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
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              await controller.setMapStyle(await rootBundle.loadString('assets/maps/map_style.txt'));
            },
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
