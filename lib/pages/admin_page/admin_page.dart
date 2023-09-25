import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/enums/day_of_week.dart';
import 'package:nightlife/enums/social_media.dart';
import 'package:nightlife/model/work_day.dart';
import 'package:nightlife/pages/admin_page/admin_login.dart';
import 'package:nightlife/pages/admin_page/review_page/review_edit_page.dart';
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
    descriptionHr: '',
    descriptionEn: '',
    location: '',
    contacts: {for (var element in Contact.values) element: null},
    socialMedia: {for (var element in SocialMedia.values) element: null},
    review: null,
    imageUrl: '',
    workHours: {for (var element in DayOfWeek.values) element: WorkDay(hours: '', typeOfMusic: [])},
  );

  late List<Club> clubs;
  @override
  void initState() {
    super.initState();
    clubs = List.from(context.read<ClubList>().clubs);
    clubs.add(_club);
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();
    if (user == null) return const AdminLogin();
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
                    child: ReviewEditPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}
