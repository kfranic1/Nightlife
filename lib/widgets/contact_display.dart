import 'package:flutter/material.dart';
import 'package:nightlife/extensions/contact_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums/contact.dart';
import '../helpers/decorated_container.dart';

class ContactDisplay extends StatelessWidget {
  const ContactDisplay({super.key, required this.data, required this.contact});

  final String? data;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    if (data == null) return Container();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: DecoratedContainer(
        child: ListTile(
          onTap: () async => await launchUrl(Uri.parse("${contact.action}$data")),
          leading: Icon(contact.icon),
          title: Text(data!),
          dense: true,
        ),
      ),
    );
  }
}
