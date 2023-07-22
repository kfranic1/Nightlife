import 'package:flutter/material.dart';

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
          club.imageName,
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
      const SizedBox(
        height: 150,
        width: 150,
        child: Icon(Icons.map),
      )
    ];
  }
}
