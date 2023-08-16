import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums/contact.dart';
import '../helpers/default_box_decoration.dart';

class ContactDisplay extends StatelessWidget {
  const ContactDisplay({super.key, required this.data, required this.contact});

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
