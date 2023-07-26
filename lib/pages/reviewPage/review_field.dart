import 'package:flutter/material.dart';
import 'package:nightlife/helpers/default_box_decoration.dart';
import 'package:nightlife/widgets/score_indicator.dart';

import '../../enums/aspect.dart';
import '../../model/review.dart';

class ReviewField extends StatefulWidget {
  const ReviewField({super.key, required Review review, required Aspect aspect})
      : _review = review,
        _aspect = aspect;

  final Review _review;
  final Aspect _aspect;

  @override
  State<ReviewField> createState() => _ReviewFieldState();
}

class _ReviewFieldState extends State<ReviewField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: DefaultBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget._aspect.toString().toUpperCase()),
          TextFormField(
            decoration: InputDecoration(
              icon: ScoreIndicator(score: widget._review.aspectReviews[widget._aspect]!.score),
              labelText: 'Score',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            initialValue: widget._review.aspectReviews[widget._aspect]!.score.toStringAsFixed(1),
            validator: (value) {
              double? num = double.tryParse(value!);
              if (num == null) return "Value can't be empty";
              if (num < 1 || num > 10) return "Value out of range [1, 10]";
              return null;
            },
            onChanged: (value) => setState(() => widget._review.aspectReviews[widget._aspect]!.score = double.tryParse(value) ?? 0),
          ),
          SizedBox(
            height: 100,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                alignLabelWithHint: true,
              ),
              initialValue: widget._review.aspectReviews[widget._aspect]!.description,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (value) => widget._review.aspectReviews[widget._aspect]!.description = value,
            ),
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
