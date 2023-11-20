import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/news_wrapper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: false,
      elevation: 0,
      expandedHeight: 320 * getScaleHeight(context),
      flexibleSpace: const NewsWrapper(),
    );
  }
}
