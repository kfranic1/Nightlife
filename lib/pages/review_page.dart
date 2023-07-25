import 'package:flutter/material.dart';
import 'package:nightlife/extensions/double_extension.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/club_text_field.dart';
import 'package:nightlife/widgets/score_indicator.dart';
import 'package:provider/provider.dart';

import '../model/club.dart';
import '../model/review.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late Club _club;
  late List<Club> _clubs;
  late Review _review;

  @override
  void initState() {
    super.initState();
    _clubs = context.read<ClubList>().clubs;
    _club = _clubs.first;
    _review = _club.review ?? Review.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          DropdownButton<Club>(
            value: _club,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(),
            focusColor: Colors.transparent,
            onChanged: (Club? club) => setState(() {
              _formKey.currentState!.reset();
              _club = club!;
              _review = club.review ?? Review.empty();
            }),
            items: _clubs
                .map((club) => DropdownMenuItem<Club>(
                      value: club,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          club.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            width: 1000,
            child: Column(
              children: _review.aspectReviews.entries
                  .map((entry) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(entry.key.toString().toUpperCase()),
                            ClubTextField(
                              labelText: 'Score',
                              initialValue: _review.aspectReviews[entry.key]!.score.toStringAsFixed(2),
                              validate: true,
                              validator: (p0) {
                                double? value = double.tryParse(p0!);
                                if (value == null) return "Value can't be empty";
                                if (value < 1 || value > 10) return "Value out of range [1, 10]";
                                return null;
                              },
                              onChanged: (value) => setState(() => _review.aspectReviews[entry.key]!.score = double.tryParse(value) ?? 0),
                              icon: Icon(
                                Icons.circle,
                                color: _review.aspectReviews[entry.key]!.score.color,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ClubTextField(
                                labelText: 'Description',
                                alignLabelWithHint: true,
                                initialValue: _review.aspectReviews[entry.key]!.description,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                onChanged: (value) => _review.aspectReviews[entry.key]!.description = value,
                              ),
                            ),
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: e,
                                  ))
                              .toList(),
                        ),
                      ))
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
          ScoreIndicator(score: _review.score, scale: 50),
          FloatingActionButton(
            onPressed: loading
                ? null
                : () async {
                    setState(() => loading = true);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await _club.updateReview(_review);
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operation successful')));
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: ${error.toString()}')));
                      }
                    }
                    setState(() => loading = false);
                  },
            child: loading ? const CircularProgressIndicator() : const Icon(Icons.save),
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
