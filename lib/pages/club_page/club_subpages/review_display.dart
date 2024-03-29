import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightlife/enums/aspect.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/extensions/review_extension.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/review.dart';
import 'package:nightlife/widgets/score_indicator.dart';
import 'package:nightlife/widgets/translatable_text.dart';
import 'package:provider/provider.dart';

class ReviewDisplay extends StatefulWidget {
  const ReviewDisplay({super.key});

  @override
  State<ReviewDisplay> createState() => _ReviewDisplayState();
}

class _ReviewDisplayState extends State<ReviewDisplay> with AutomaticKeepAliveClientMixin<ReviewDisplay> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  late final Future<Review?> reviewFuture;
  List<Aspect> aspects = List<Aspect>.from(Aspect.values).rearrange((p0, p1) => p0.index.compareTo(p1.index));

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    reviewFuture = Review.tryGetReview(context.read<Club>().id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: FutureBuilder<Review?>(
          future: reviewFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const CircularProgressIndicator();
            if (!snapshot.hasData) return const Center(child: Text("This club has not yet been reviewed."));
            Review review = snapshot.data!;
            return SizedBox(
              width: min(400, MediaQuery.of(context).size.width - 20),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        Aspect aspect = aspects[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TranslatableText(
                                    textHr: aspect.titleHr,
                                    textEn: aspect.titleEn,
                                    style: const TextStyle(fontSize: 28),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 12),
                                  ScoreIndicator(
                                    score: review.aspectReviews[aspect]!.score,
                                    scale: 40,
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                                height: 20,
                                thickness: 2,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: TranslatableText(
                                    textHr: review.aspectReviews[aspect]!.descriptionHr,
                                    textEn: review.aspectReviews[aspect]!.descriptionEn,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
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
                      aspects.length,
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
                  ),
                  Text(
                    review.reviewDateDescription,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            );
          }),
    );
  }
}
