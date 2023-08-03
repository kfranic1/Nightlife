import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:nightlife/widgets/score_indicator.dart';
import 'package:provider/provider.dart';

import '../enums/aspect.dart';
import '../model/review.dart';

class ReviewDisplay extends StatefulWidget {
  const ReviewDisplay({super.key});

  @override
  State<ReviewDisplay> createState() => _ReviewDisplayState();
}

class _ReviewDisplayState extends State<ReviewDisplay> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  late Review? review;
  List<Aspect> aspects = List<Aspect>.from(Aspect.values).rearrange((p0, p1) => p0.index.compareTo(p1.index));

  @override
  void initState() {
    super.initState();
    review = context.read<Review?>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              Aspect aspect = aspects[index];
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: DefaultBoxDecoration(),
                child: Column(
                  children: [
                    Text(
                      aspect.toString(),
                      style: const TextStyle(fontSize: 28),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                    ),
                    Expanded(
                      child: Text(
                        review!.aspectReviews[aspect]!.description,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    ScoreIndicator(
                      score: review!.aspectReviews[aspect]!.score,
                      scale: 72,
                    ),
                  ],
                ),
              );
            },
            itemCount: aspects.length,
            onPageChanged: (value) => setState(() => _currentPage = value),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (listIndex) => IconButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(Icons.circle),
              color: _currentPage == listIndex ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () => _controller.animateToPage(
                listIndex,
                duration: Duration(milliseconds: (250 * pow(1.33, (_currentPage - listIndex).abs())).round()),
                curve: Curves.easeIn,
              ),
            ),
          ),
        )
      ],
    );
  }
}
