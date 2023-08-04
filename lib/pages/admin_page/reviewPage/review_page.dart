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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueKey<int> _valueKey = const ValueKey<int>(0);
  late Review _review;
  late Club _club;

  @override
  Widget build(BuildContext context) {
    _valueKey = ValueKey<int>(_valueKey.value + 1);
    _club = context.watch<Club>();
    if (_club.id.isEmpty)
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Placeholder(),
      );
    _review = Review.from(_club.review ?? Review.empty());
    return Form(
      key: _formKey,
      child: Column(
        key: _valueKey,
        children: <Widget>[
          reviewFields(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: FormButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await FormButton.tryAction(context, () async => await _club.updateReview(_review));
                      }
                    },
                    label: "Save",
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                FormButton(
                  action: () async => setState(() {}),
                  label: 'Discard changes',
                ),
                const SizedBox(width: 10),
                FormButton(
                  action: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Are you sure you want to delete this review?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                            TextButton(
                              onPressed: () async {
                                FormButton.tryAction(context, () async => await _club.updateReview(null));
                                setState(() {});
                                if (context.mounted) Navigator.of(context).pop();
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.red,
                  label: "Delete",
                ),
              ],
            ),
          ),
        ],
      ),
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
