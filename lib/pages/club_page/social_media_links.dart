import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/enums/social_media.dart';
import 'package:nightlife/extensions/social_media_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({super.key});

  @override
  Widget build(BuildContext context) {
    Map<SocialMedia, String?> socialMedia = context.read<Club>().socialMedia;
    return Wrap(
      spacing: 16,
      children: SocialMedia.values
          .where((media) => socialMedia[media] != null)
          .map((media) => SocialMediaButton(socialMedia: media, data: socialMedia[media]!))
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
    return Seo.link(
      anchor: socialMedia.name,
      href: data,
      child: IconButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 32,
        onPressed: () async => await launchUrl(Uri.parse(data)),
        icon: FaIcon(socialMedia.icon),
      ),
    );
  }
}
