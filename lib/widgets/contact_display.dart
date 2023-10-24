import 'package:flutter/material.dart';
import 'package:nightlife/enums/contact.dart';
import 'package:nightlife/extensions/contact_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDisplay extends StatelessWidget {
  const ContactDisplay({super.key, required this.data, required this.contact});

  final String data;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        onTap: () async => await launchUrl(Uri.parse("${contact.action}$data")),
        leading: Icon(contact.icon),
        title: Text(data),
      ),
    );
  }
}
