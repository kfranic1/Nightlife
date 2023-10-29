import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/extensions/geopoint_extension.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/google_maps_page/marker/custom_marker.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  List<Point> clubPoints = []; // To store calculated screen positions of clubs
  double markerRadius = 25;

  // Method to update the screen positions of markers based on map camera position
  Future<void> _updateMarkers(List<Club> clubs) async {
    GoogleMapController controller = await _controller.future;
    clubPoints.clear();

    for (var club in clubs) {
      final screenPoint = await controller.getScreenCoordinate(club.location.pin.latLng);
      clubPoints.add(Point(
        x: screenPoint.x.toDouble(),
        y: screenPoint.y.toDouble(),
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Club> clubs = context.read<ClubList>().clubs;
    double markerRadius = 25;
    double avgLat = clubs.map((club) => club.location.pin.latLng.latitude).reduce((a, b) => a + b) / clubs.length;
    double avgLng = clubs.map((club) => club.location.pin.latLng.longitude).reduce((a, b) => a + b) / clubs.length;
    LatLng avgLatLng = LatLng(avgLat, avgLng);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 0,
        title: TextButton(
          onPressed: () => context.read<CustomRouterDelegate>().goToHome(),
          child: GradientText(
            'NIGHTLIFE ZAGREB',
            style: Theme.of(context).textTheme.headlineLarge,
            colors: const [
              Color.fromARGB(255, 0, 255, 255),
              Color.fromARGB(255, 255, 0, 255),
            ],
            overflow: TextOverflow.visible,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<CustomRouterDelegate>().goToProfile(),
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () => context.read<CustomRouterDelegate>().goToMaps(),
            icon: const Icon(Icons.pin_drop),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              padding: const EdgeInsets.only(bottom: 100.0),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: avgLatLng,
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                await controller.setMapStyle(await rootBundle.loadString('assets/maps/map_style.txt'));
                await _updateMarkers(clubs);
              },
              onCameraMove: (_) async => await _updateMarkers(clubs),
              onCameraIdle: () async => await _updateMarkers(clubs),
              zoomControlsEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: false,
            ),
            for (var i = 0; i < clubPoints.length; i++)
              Positioned(
                left: clubPoints[i].x - markerRadius,
                top: clubPoints[i].y - 2.8 * markerRadius,
                child: CustomMarker(
                  imageUrl: clubs[i].imageUrl,
                  radius: markerRadius,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}
