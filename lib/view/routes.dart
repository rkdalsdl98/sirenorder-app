import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/view/basket.dart';
import 'package:sirenorder_app/view/bills.dart';
import 'package:sirenorder_app/view/coupon.dart';
import 'package:sirenorder_app/view/gift.dart';
import 'package:sirenorder_app/view/gift_box.dart';
import 'package:sirenorder_app/view/gift_detail.dart';
import 'package:sirenorder_app/view/home.dart';
import 'package:sirenorder_app/view/login.dart';
import 'package:sirenorder_app/view/menu_info.dart';
import 'package:sirenorder_app/view/payment.dart';
import 'package:sirenorder_app/view/payment_result.dart';
import 'package:sirenorder_app/view/store.dart';

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
          child: BlocProvider.value(
            value: routeContext.read<UserBloc>(),
            child: Login(initialPage: args["page"]),
          ),
        ),
      );
    case '/payment':
      return MaterialPageRoute(
        builder: (_) => Payment(
          order: args['order'],
          type: args['type'],
        ),
      );
    case '/payment-result':
      return MaterialPageRoute(
          builder: (_) => PaymentResult(
                result: args['result'],
                type: args['type'],
              ));
    case '/gift':
      return MaterialPageRoute(
        builder: (routeContext) => RepositoryProvider.value(
          value: routeContext.read<UserRepository>(),
          child: BlocProvider.value(
            value: routeContext.read<UserBloc>(),
            child: Gift(
              json: args['menu'],
              type: args['type'],
            ),
          ),
        ),
      );
    case '/store':
      return MaterialPageRoute(builder: (routeContext) => Store());
    case '/menu-info':
      return MaterialPageRoute(
        builder: (routeContext) => MenuDetail(
          json: args['menu'],
          type: args['type'],
        ),
      );
    case '/basket':
      return MaterialPageRoute(builder: (routeContext) => const Basket());
    case '/gift-box':
      return MaterialPageRoute(
        builder: (routeContext) => RepositoryProvider.value(
          value: routeContext.read<UserRepository>(),
          child: BlocProvider.value(
            value: routeContext.read<UserBloc>(),
            child: const GiftBox(),
          ),
        ),
      );
    case '/gift-detail':
      return MaterialPageRoute(
          builder: (routeBuilder) => GiftDetail(
                data: args['gift'],
              ));
    case '/coupon':
      return MaterialPageRoute(
          builder: (routeContext) => RepositoryProvider.value(
              value: routeContext.read<UserRepository>(),
              child: BlocProvider.value(
                  value: routeContext.read<UserBloc>(),
                  child: const Coupon())));
    case '/bills':
      return MaterialPageRoute(
        builder: (routeContext) => RepositoryProvider.value(
          value: routeContext.read<UserRepository>(),
          child: BlocProvider.value(
            value: routeContext.read<UserBloc>(),
            child: const Bills(),
          ),
        ),
      );
    default:
      return null;
  }
}
