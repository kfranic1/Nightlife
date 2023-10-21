import 'package:flutter/material.dart';
import 'package:nightlife/extensions/list_extension.dart';
import 'package:nightlife/helpers/constants.dart';
import 'package:nightlife/model/club.dart';
import 'package:nightlife/model/review.dart';
import 'package:nightlife/pages/admin_page/form_button.dart';
import 'package:nightlife/pages/admin_page/review_page/review_field.dart';
import 'package:provider/provider.dart';

class ReviewEditPage extends StatefulWidget {
  const ReviewEditPage({super.key});

  @override
  State<ReviewEditPage> createState() => _ReviewEditPageState();
}

class _ReviewEditPageState extends State<ReviewEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueKey<int> _valueKey = const ValueKey<int>(0);
  late Review _review;
  late Club _club;

  @override
  Widget build(BuildContext context) {
    _valueKey = ValueKey<int>(_valueKey.value + 1);
    _club = context.watch<Club>();
    if (_club.id.isEmpty) return const SizedBox();
    return FutureBuilder(
        future: _club.hasReview ? Review.getReview(_club.id) : Future.value(Review.empty(_club.id)),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          _review = snapshot.data as Review;
          return Form(
            key: _formKey,
            child: Column(
              key: _valueKey,
              children: <Widget>[
                const Text("Review info"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: ddMMyyyyFormater.format(_review.date),
                    decoration: InputDecoration(
                      labelText: 'Date dd.MM.yyyy',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    validator: (value) {
                      if (!RegExp(r'^(\d{2})\.(\d{2})\.(\d{4})').hasMatch(value!)) return "Wrong format";
                      try {
                        ddMMyyyyFormater.parseStrict(value);
                        return null;
                      } catch (e) {
                        return "Date is not correct";
                      }
                    },
                    onChanged: (value) {
                      try {
                        _review.date = ddMMyyyyFormater.parseStrict(value);
                      } catch (e) {
                        _review.date = DateTime.now();
                      }
                    },
                  ),
                ),
                Column(
                  children: _review.aspectReviews.entries
                      .toList()
                      .rearrange((p0, p1) => p0.toString().compareTo(p1.toString()))
                      .map((entry) => ReviewField(review: _review, aspect: entry.key))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormButton(
                          action: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await FormButton.tryAction(context, () async => await _review.setReview());
                            }
                          },
                          label: "Save",
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
