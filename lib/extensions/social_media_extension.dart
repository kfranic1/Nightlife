import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/enums/social_media.dart';

extension SocialMediaExtension on SocialMedia {
  IconData get icon {
    switch (this) {
      case SocialMedia.facebook:
        return FontAwesomeIcons.facebook;
      case SocialMedia.instagram:
        return FontAwesomeIcons.instagram;
    }
  }
}
