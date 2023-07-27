import 'package:flutter/material.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enums/contact.dart';
import '../../model/club.dart';

class ClubPageInfo extends StatelessWidget {
  final Club club;

  const ClubPageInfo({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.network(
              club.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20, width: 20),
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
          const SizedBox(height: 20, width: 20),
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Contact.values.map((e) => ContactElement(data: club.contacts[e], contact: e)).toList(),
            ),
          ),
        ],
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
