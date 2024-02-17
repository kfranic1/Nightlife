import 'package:flutter/material.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/selected_club.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/services/club_data_service.dart';
import 'package:provider/provider.dart';

class MapNavigation extends StatelessWidget {
  const MapNavigation({super.key, required this.selectedClub});

  final SelectedClub selectedClub;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 80,
        child: Builder(builder: (context) {
          List<Club> filteredClubs = context.select<ClubDataService, List<Club>>((value) => value.filteredClubs);
          Club? club = selectedClub.club;
          if (club == null) return const SizedBox();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => selectedClub.selectPrevious(filteredClubs),
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 192,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  onPressed: () {
                    context.read<CustomRouterDelegate>().goToClub(club.name);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        club.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        club.location.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => selectedClub.selectNext(filteredClubs),
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          );
        }),
      ),
    );
  }
}
