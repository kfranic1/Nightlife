import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/extensions/double_extension.dart';
import 'package:nightlife/extensions/review_extension.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../model/club.dart';
import '../routing/custom_router_delegate.dart';
import 'score_indicator.dart';

class ClubTile extends StatefulWidget {
  final Club club;
  final double width;

  const ClubTile({super.key, required this.club, required this.width});

  @override
  State<ClubTile> createState() => _ClubTileState();
}

class _ClubTileState extends State<ClubTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double tileHeight = constraints.maxWidth > kWidthWeb ? 100 : 72;
      double nameFontSize = constraints.maxWidth > kWidthWeb ? 24 : 16;
      double infoFontSize = constraints.maxWidth > kWidthWeb ? 14 : 12;
      return Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          width: min(1000, widget.width) * (_isHovering ? 1.05 : 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isHovering = true),
              onTapCancel: () => setState(() => _isHovering = false),
              onTap: () => context.read<CustomRouterDelegate>().goToClub({"name": widget.club.name}),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _isHovering ? widget.club.score.color.withAlpha(50) : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.club.imageUrl,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.fill,
                        height: tileHeight,
                        width: tileHeight,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: tileHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.club.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: nameFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.club.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: infoFontSize),
                              ),
                              const Expanded(child: SizedBox()),
                              if (widget.club.typeOfMusic.isNotEmpty)
                                Text(
                                  widget.club.typeOfMusic.join(', '),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: infoFontSize),
                                ),
                              const Expanded(child: SizedBox()),
                              Text(
                                widget.club.review.reviewDateDescription,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: infoFontSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (widget.club.score != 0)
                        ScoreIndicator(
                          score: widget.club.score,
                          scale: tileHeight,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
