import 'package:flutter/material.dart';
import 'package:sirenorder_app/widget/home/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        HomeAppBar(),
      ],
    );
  }
}
