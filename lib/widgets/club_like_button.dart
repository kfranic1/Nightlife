import 'package:flutter/material.dart';
import 'package:nightlife/extensions/person_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/person.dart';
import 'package:provider/provider.dart';

class ClubLikeButton extends StatefulWidget {
  const ClubLikeButton({super.key, required this.club});

  final Club club;

  @override
  State<ClubLikeButton> createState() => _ClubLikeButtonState();
}

class _ClubLikeButtonState extends State<ClubLikeButton> {
  @override
  Widget build(BuildContext context) {
    Person? user = context.watch<Person?>();
    return IconButton(
      //label: Text(widget.club.favoriteCount.toString()),
      icon: (user == null || !user.favourites.contains(widget.club.id))
          ? const Icon(Icons.favorite_border, color: Colors.grey)
          : const Icon(Icons.favorite, color: Colors.red),
      onPressed: user == null
          ? null
          : () async {
              await user.handleFavourite(widget.club);
              setState(() {});
            },
    );
  }
}
