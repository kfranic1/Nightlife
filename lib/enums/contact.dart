import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Contact {
  facebook,
  instagram,
  web,
  phone,
  email,
}

extension ContactIcon on Contact {
  IconData get icon {
    switch (this) {
      case Contact.facebook:
        return FontAwesomeIcons.facebook;
      case Contact.instagram:
        return FontAwesomeIcons.instagram;
      case Contact.web:
        return Icons.web;
      case Contact.phone:
        return Icons.phone;
      case Contact.email:
        return Icons.email;
    }
  }

  String get action {
    switch (this) {
      case Contact.facebook:
      case Contact.instagram:
      case Contact.web:
        return "https://";
      case Contact.phone:
        return "tel:";
      case Contact.email:
        return "mailto:";
    }
  }
}
