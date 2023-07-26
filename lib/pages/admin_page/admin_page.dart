import 'package:flutter/material.dart';
import 'package:nightlife/pages/admin_page/reviewPage/review_page.dart';
import 'package:provider/provider.dart';

import '../../enums/contact.dart';
import '../../helpers/club_list.dart';
import '../../model/club.dart';
import '../../widgets/club_dropdown.dart';
import 'club_edit_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Club _club = Club(
    id: '',
    name: 'New Club',
    description: '',
    location: '',
    typeOfMusic: [],
    contacts: {for (var element in Contact.values) element: null},
    review: null,
    imageUrl: '',
  );

  late List<Club> clubs;
  late List<bool> typeOfMusicSelected;
  @override
  void initState() {
    super.initState();
    clubs = List.from(context.read<ClubList>().clubs);
    clubs.add(_club);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClubDropdown(
            club: _club,
            clubs: clubs,
            onChanged: (Club? club) => setState(() => _club = club!),
          ),
        ),
        const Divider(height: 2, thickness: 2, color: Colors.black),
        Provider.value(
          value: _club,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FocusScope(
                  node: FocusScopeNode(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClubEditPage(),
                  ),
                ),
              ),
              Expanded(
                child: FocusScope(
                  node: FocusScopeNode(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ReviewPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
