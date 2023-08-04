import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: primaryColor,
            size: 75,
          ),
          SizedBox(height: 10),
          Text(
            'This page does not exist.',
            style: TextStyle(
              fontSize: 32,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
