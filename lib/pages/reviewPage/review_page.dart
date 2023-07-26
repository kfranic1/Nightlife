import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:provider/provider.dart';

import '../../model/club.dart';
import '../../model/review.dart';
import '../../widgets/club_dropdown.dart';
import 'review_field.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  ValueKey<int> _formKey = const ValueKey<int>(0);
  late Club _club;
  late List<Club> _clubs;
  late Review _review;

  @override
  void initState() {
    super.initState();
    _clubs = context.read<ClubList>().clubs;
    _club = _clubs.first;
    _review = Review.from(_club.review ?? Review.empty());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formStateKey,
        child: ListView(
          key: _formKey,
          children: <Widget>[
            dropdownButton(),
            const Divider(height: 2, thickness: 2, color: Colors.black),
            discardButton(),
            reviewFields(),
            FormButton(
              club: _club,
              review: _review,
              formStateKey: _formStateKey,
            ),
          ].addPadding(),
        ),
      ),
    );
  }

  Widget dropdownButton() {
    return ClubDropdown(
      club: _club,
      clubs: _clubs,
      onChanged: (Club? club) {
        if (_club.review != null && !_review.isEqual(_club.review!)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Some changes are not saved')));
          return;
        }
        setState(() {
          _club = club!;
          _review = Review.from(_club.review ?? Review.empty());
          _formKey = ValueKey<int>(_formKey.value + 1);
        });
      },
    );
  }

  Widget discardButton() {
    return ElevatedButton(
      onPressed: () => setState(() {
        _formKey = ValueKey<int>(_formKey.value + 1);
        _review = Review.from(_club.review ?? Review.empty());
      }),
      child: const Text('Discard changes'),
    );
  }

  Widget reviewFields() {
    return Column(
      children: _review.aspectReviews.entries
          .toList()
          .rearrange((p0, p1) => p0.toString().compareTo(p1.toString()))
          .map((entry) => ReviewField(review: _review, aspect: entry.key))
          .toList()
          .addPadding(),
    );
  }
}

class FormButton extends StatefulWidget {
  const FormButton({super.key, required Club club, required Review review, required GlobalKey<FormState> formStateKey})
      : _club = club,
        _review = review,
        _formStateKey = formStateKey;

  final Club _club;
  final Review _review;
  final GlobalKey<FormState> _formStateKey;

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading
          ? null
          : () async {
              setState(() => loading = true);
              if (widget._formStateKey.currentState!.validate()) {
                widget._formStateKey.currentState!.save();
                try {
                  await widget._club.updateReview(widget._review);
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operation successful')));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: ${error.toString()}')));
                }
              }
              setState(() => loading = false);
            },
      child: loading ? const CircularProgressIndicator() : const Text("Save"),
    );
  }
}
