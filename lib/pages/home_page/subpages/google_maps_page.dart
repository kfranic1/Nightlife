import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/constants.dart';
import 'package:nightlife/helpers/primary_swatch.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/selected_club.dart';
import 'package:nightlife/widgets/map_navigation.dart';
import 'package:nightlife/widgets/marker/custom_marker.dart';
import 'package:provider/provider.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  final SelectedClub _selectedClub = SelectedClub();
  late final Map<Club, ScreenCoordinate> clubPoints;
  late final ClubList clubList;

  List<Club> get _displayClubs => clubList.filteredClubs;
  Club? get _club => _selectedClub.club;

  @override
  void initState() {
    clubList = context.read<ClubList>();
    clubPoints = Map.fromIterable(
      clubList.clubs,
      key: (element) => element,
      value: (element) => const ScreenCoordinate(x: 0, y: 0),
    );

    _selectedClub.addListener(onSelectedClubUpdated);
    _selectedClub.select(_displayClubs.lastOrNull);

    clubList.addListener(onClubListUpdated);

    super.initState();
  }

  @override
  void dispose() {
    _selectedClub.removeListener(onSelectedClubUpdated);

    clubList.removeListener(onClubListUpdated);

    super.dispose();
  }

  void onClubListUpdated() {
    if (!_displayClubs.contains(_club))
      _selectedClub.select(_displayClubs.lastOrNull);
    else
      _selectedClub.select(_club);
  }

  void onSelectedClubUpdated() async {
    if (_club != null) {
      GoogleMapController controller = await _controller.future;
      controller.moveCamera(CameraUpdate.newLatLng(_club!.location.pin));
    }
    _updateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (_) {},
                child: GoogleMap(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _club != null ? _club!.location.pin : clubList.clubCenter,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    controller.setMapStyle(await rootBundle.loadString('assets/maps/map_style.txt'));
                    _updateMarkers();
                  },
                  onCameraMove: (_) => _updateMarkers(),
                  onCameraIdle: () => _updateMarkers(),
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: false,
                ),
              ),
              for (Club club in List.from(_displayClubs)..remove(_club)) clubPositioned(club, Colors.grey),
              if (_club != null) clubPositioned(_club!, primaryColor),
            ],
          ),
        ),
        MapNavigation(selectedClub: _selectedClub),
      ],
    );
  }

  Widget clubPositioned(Club club, Color color) {
    double markerRadius = MediaQuery.of(context).size.width < kWidthWeb ? 25 : 40;

    return Positioned(
      left: clubPoints[club]!.x - markerRadius,
      top: clubPoints[club]!.y - 2.8 * markerRadius,
      child: GestureDetector(
        onHorizontalDragUpdate: (_) {},
        onTap: () => _selectedClub.select(club),
        child: CustomMarker(
          imageUrl: club.imageUrl,
          radius: markerRadius,
          color: color,
        ),
      ),
    );
  }

  Future<void> _updateMarkers() async {
    GoogleMapController controller = await _controller.future;
    await Future.wait(_displayClubs.map(
      (club) async => clubPoints[club] = await controller.getScreenCoordinate(club.location.pin),
    ));
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
