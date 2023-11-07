import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/constants.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/widgets/marker/custom_marker.dart';
import 'package:provider/provider.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> with AutomaticKeepAliveClientMixin {
  late final GoogleMapController _controller;
  late Map<Club, ScreenCoordinate> clubPoints;

  Future<void> _updateMarkers(List<Club> clubs) async {
    await Future.wait(clubs.map(
      (club) async => clubPoints[club] = await _controller.getScreenCoordinate(club.location.pin),
    ));
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    clubPoints = Map.fromIterable(
      context.read<ClubList>().clubs,
      key: (element) => element,
      value: (element) => const ScreenCoordinate(x: 0, y: 0),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double markerRadius = MediaQuery.of(context).size.width < kWidthWeb ? 25 : 40;
    List<Club> clubs = context.watch<ClubList>().filteredClubs;
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
            _controller = controller;
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
            child: GestureDetector(
              onTap: () => context.read<ClubList>().bringForward(club),
              child: CustomMarker(
                imageUrl: club.imageUrl,
                radius: markerRadius,
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
