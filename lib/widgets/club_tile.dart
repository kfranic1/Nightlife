import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/extensions/club_extension.dart';
import 'package:provider/provider.dart';

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
      double tileHeight = constraints.maxWidth > 600 ? 100 : 72;
      double nameFontSize = constraints.maxWidth > 600 ? 24 : 16;
      double infoFontSize = constraints.maxWidth > 600 ? 14 : 12;
      return Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          width: min(1000, widget.width) * (_isHovering ? 1.1 : 1),
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
              onTap: () => context.read<CustomRouterDelegate>().goToClub({"name": widget.club.name}),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _isHovering ? widget.club.color.withAlpha(50) : Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.club.imageUrl,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.fill,
                        height: tileHeight,
                        width: tileHeight,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                              const SizedBox(height: 4),
                              Text(
                                widget.club.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: infoFontSize),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.green[400],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                                  child: Text(
                                    widget.club.typeOfMusic.first.toString().toUpperCase() +
                                        ((widget.club.typeOfMusic.length > 1) ? " +${widget.club.typeOfMusic.length - 1} more" : ""),
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                widget.club.lastReview,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: infoFontSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ScoreIndicator(
                        score: widget.club.score,
                        color: widget.club.color,
                        scale: tileHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
