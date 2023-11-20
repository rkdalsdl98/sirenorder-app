import 'package:flutter/material.dart';
import 'package:sirenorder_app/view/home.dart';

Route<dynamic>? initGeneratedRoutes(
  RouteSettings settings,
  BuildContext context,
) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());
    default:
      return null;
  }
}
