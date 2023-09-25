import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/enums/social_media.dart';
import 'package:nightlife/extensions/social_media_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: SocialMedia.values
          .where((socialMedia) => club.socialMedia[socialMedia] != null)
          .map((socialMedia) => SocialMediaButton(socialMedia: socialMedia, data: club.socialMedia[socialMedia]!))
          .toList(),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key, required this.socialMedia, required this.data});

  final SocialMedia socialMedia;
  final String data;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconSize: 40,
      onPressed: () async => await launchUrl(Uri.parse(data)),
      icon: FaIcon(socialMedia.icon),
    );
  }
}
