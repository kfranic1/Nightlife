import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enums/contact.dart';
import '../../model/club.dart';
import '../../model/work_day.dart';

class ClubPageInfo extends StatelessWidget {
  const ClubPageInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Club club = context.watch<Club>();
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: NestedSingleChildScrollView(
        child: Column(
          children: [
            SizedBox.square(
              dimension: 150,
              child: Image.network(
                club.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox.square(dimension: 20),
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
            const SizedBox.square(dimension: 20),
            SizedBox(
              width: min(400, MediaQuery.of(context).size.width - 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Contact.values.map((e) => ContactElement(data: club.contacts[e], contact: e)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
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
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
