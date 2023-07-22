import 'dart:math';

import 'package:flutter/material.dart';
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
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        width: min(1000, widget.width) * (_isHovering ? 1.2 : 1),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _isHovering ? widget.club.color.withAlpha(50) : Colors.transparent,
            ),
            child: ListTile(
              onTap: () => context.read<CustomRouterDelegate>().goToClub({"name": widget.club.name}),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              hoverColor: Colors.transparent,
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Image.network(
                  widget.club.imageName,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                widget.club.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.club.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: ScoreIndicator(score: widget.club.score, color: widget.club.color, scale: 50),
            ),
          ),
        ),
      ),
    );
  }
}
