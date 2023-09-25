import 'package:flutter/material.dart';

import '../enums/contact.dart';

extension ContactExtension on Contact {
  IconData get icon {
    switch (this) {
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
      case Contact.web:
        return "https://";
      case Contact.phone:
        return "tel:";
      case Contact.email:
        return "mailto:";
    }
  }
}
