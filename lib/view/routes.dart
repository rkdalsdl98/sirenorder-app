import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
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
        builder: (routeContext) => RepositoryProvider.value(
          value: routeContext.read<UserRepository>(),
          child: Login(initialPage: args["page"]),
        ),
      );
    default:
      return null;
  }
}
