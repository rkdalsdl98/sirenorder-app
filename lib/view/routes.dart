import 'package:flutter/material.dart';
import 'package:sirenorder_app/view/home.dart';
import 'package:sirenorder_app/view/login.dart';

Route<dynamic>? initGeneratedRoutes(
  RouteSettings settings,
  BuildContext context,
) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());
    case '/login':
      return MaterialPageRoute(
          builder: (_) => Login(initialPage: args["page"]));
    default:
      return null;
  }
}
