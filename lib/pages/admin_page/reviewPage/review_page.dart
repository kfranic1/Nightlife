import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:provider/provider.dart';

import '../../../model/club.dart';
import '../../../model/review.dart';
import '../form_button.dart';
import 'review_field.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  ValueKey<int> _formKey = const ValueKey<int>(0);
  late Review _review;
  late Club _club;

  @override
  Widget build(BuildContext context) {
    _formKey = ValueKey<int>(_formKey.value + 1);
    _club = context.watch<Club>();
    if (_club.id.isEmpty)
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Placeholder(),
      );
    _review = Review.from(_club.review ?? Review.empty());
    return Form(
      key: _formStateKey,
      child: Column(
        key: _formKey,
        children: <Widget>[
          reviewFields(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                discardButton(),
                const SizedBox(width: 10),
                Expanded(child: FormButton(formStateKey: _formStateKey, action: () async => await _club.updateReview(_review))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget discardButton() {
    return ElevatedButton(
      onPressed: () => setState(() => _review = Review.from(_club.review ?? Review.empty())),
      child: const Text('Discard changes'),
    );
  }

  Widget reviewFields() {
    return Column(
      children: _review.aspectReviews.entries
          .toList()
          .rearrange((p0, p1) => p0.toString().compareTo(p1.toString()))
          .map((entry) => ReviewField(review: _review, aspect: entry.key))
          .toList(),
    );
  }
}
