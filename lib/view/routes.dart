import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/view/home.dart';
import 'package:sirenorder_app/view/login.dart';
import 'package:sirenorder_app/view/payment.dart';

Route<dynamic>? initGeneratedRoutes(
  RouteSettings settings,
  BuildContext context,
) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case '/':
      print(args);
      return MaterialPageRoute(builder: (_) => const Home());
    case '/login':
      return MaterialPageRoute(
        builder: (routeContext) => RepositoryProvider.value(
          value: routeContext.read<UserRepository>(),
          child: BlocProvider.value(
            value: routeContext.read<UserBloc>(),
            child: Login(initialPage: args["page"]),
          ),
        ),
      );
    case '/payment':
      return MaterialPageRoute(builder: (_) => const Payment());
    default:
      return null;
  }
}
