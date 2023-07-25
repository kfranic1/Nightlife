import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enums/contact.dart';
import '../../model/club.dart';

class ClubPageTop extends StatelessWidget {
  final Club club;

  const ClubPageTop({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 700) {
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: children(),
          );
        } else {
          return Row(children: children());
        }
      },
    );
  }

  List<Widget> children() {
    return [
      SizedBox(
        width: 150,
        height: 150,
        child: Image.network(
          club.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(height: 20, width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20, width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Contact.values.map((e) => ContactElement(data: club.contacts[e], contact: e)).toList(),
      ),
      const SizedBox(height: 20, width: 20),
      const SizedBox(
        height: 150,
        width: 150,
        child: Icon(Icons.map),
      )
    ];
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async => await launchUrl(Uri.parse("${contact.action}$data")),
          child: Row(
            children: [Icon(contact.icon), Text(' $data')],
          ),
        ),
      ),
    );
  }
}
