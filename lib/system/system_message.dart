import 'package:flutter/material.dart';

void showSnackBarMessage(
  BuildContext context,
  String message,
) {
  Future.delayed(Duration.zero).then(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    ),
  );
}
