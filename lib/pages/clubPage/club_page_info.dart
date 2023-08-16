import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enums/contact.dart';
import '../../model/club.dart';
import '../../model/work_day.dart';

class ClubPageInfo extends StatefulWidget {
  const ClubPageInfo({super.key});

  @override
  State<ClubPageInfo> createState() => _ClubPageInfoState();
}

class _ClubPageInfoState extends State<ClubPageInfo> with AutomaticKeepAliveClientMixin<ClubPageInfo> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Club club = context.watch<Club>();
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            SizedBox.square(
              dimension: 150,
              child: Image.network(
                club.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              club.name,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              club.location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24),
            ),
            Container(
              width: min(400, MediaQuery.of(context).size.width - 20),
              decoration: DefaultBoxDecoration(),
              child: ExpansionTile(
                title: const Text("Contacts & Social Media"),
                children: Contact.values.map((e) => ContactElement(data: club.contacts[e], contact: e)).toList(),
              ),
            ),
            Container(
              width: min(400, MediaQuery.of(context).size.width - 20),
              decoration: DefaultBoxDecoration(),
              child: ExpansionTile(
                shape: const Border(),
                maintainState: true,
                title: const Text("Work days"),
                children: club.workHours.keys
                    .toList()
                    .where((element) => club.workHours[element]!.open)
                    .toList()
                    .rearrange((p0, p1) => p0.index - p1.index)
                    .map((dayOfWeek) {
                  WorkDay day = club.workHours[dayOfWeek]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: DefaultBoxDecoration(),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: dayOfWeek.name.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      TextSpan(text: '(${day.typeOfMusic.join(',')})'),
                                    ]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                day.hours,
                                maxLines: 1,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (club.review != null)
              const Text(
                "Scroll down to see the review",
                style: TextStyle(color: Colors.grey),
              )
          ],
        ),
      ),
    );
  }
}

class ContactElement extends StatelessWidget {
  const ContactElement({super.key, required this.data, required this.contact});

  final String? data;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    if (data == null) return Container();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: DefaultBoxDecoration(),
          child: ListTile(
            onTap: () async => await launchUrl(Uri.parse("${contact.action}$data")),
            leading: Icon(contact.icon),
            title: Text(data!),
          ),
        ),
      ),
    );
  }
}
