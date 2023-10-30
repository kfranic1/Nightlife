import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/extensions/geopoint_extension.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/pages/google_maps_page/marker/custom_marker.dart';
import 'package:provider/provider.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late Map<Club, ScreenCoordinate> clubPoints;
  double markerRadius = 25;

  Future<void> _updateMarkers(List<Club> clubs) async {
    GoogleMapController controller = await _controller.future;

    Future.wait(List.generate(
      clubs.length,
      (i) => controller.getScreenCoordinate(clubs[i].location.pin.latLng).then((coord) => clubPoints[clubs[i]] = coord),
    )).then((_) => setState(() {}));
  }

  @override
  void initState() {
    clubPoints = Map.fromIterable(context.read<ClubList>().clubs, key: (element) => element, value: (element) => const ScreenCoordinate(x: 0, y: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Club> clubs = context.watch<ClubList>().filteredClubs;
    print(clubs.length);
    return Stack(
      children: [
        GoogleMap(
          padding: const EdgeInsets.only(bottom: 100.0),
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: context.read<ClubList>().clubCenter,
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
        for (Club club in clubs)
          Positioned(
            left: clubPoints[club]!.x - markerRadius,
            top: clubPoints[club]!.y - 2.8 * markerRadius,
            child: CustomMarker(
              imageUrl: club.imageUrl,
              radius: markerRadius,
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
