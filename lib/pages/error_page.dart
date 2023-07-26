import 'package:flutter/material.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage = 'This page does not exist.';

  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.redAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<CustomRouterDelegate>().goToHome();
            },
            child: const Text('Go to Home Page'),
          ),
        ],
      ),
    );
  }
}
