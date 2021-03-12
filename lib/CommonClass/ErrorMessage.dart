import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorMessage extends StatelessWidget {
  String errorMessagedefault =
      " Unable to connect with Platform . Please wait it will connect after 1 min";
  String errorMessage;
  final Function onRetryPressed;
  ErrorMessage({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessagedefault,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
