import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message,
) {
  if (message == 'Success') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(),
      ),
      backgroundColor: Colors.green,
    ));
  } else if (message == 'user-not-found') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(),
        ),
        backgroundColor: Colors.red));
  } else if (message == 'wrong-password') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(),
        ),
        backgroundColor: Colors.red));
  }
}
