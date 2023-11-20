import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';

class AppMenuBar extends StatefulWidget {
  final int currIndex;
  final void Function(int value) onChangeIndex;

  const AppMenuBar({
    super.key,
    required this.currIndex,
    required this.onChangeIndex,
  });

  @override
  State<AppMenuBar> createState() => _AppMenuBarState();
}

class _AppMenuBarState extends State<AppMenuBar> {
  Color selColor = const Color(0xFF1CBA3E);
  Color defaultColor = const Color(0xFF75777F);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.currIndex,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      indicatorColor: Colors.transparent,
      height: 60 * getScaleHeight(context),
      onDestinationSelected: (value) => widget.onChangeIndex(value),
      destinations: [
        NavigationDestination(
            icon: Icon(
              Icons.home,
              color: widget.currIndex == 0 ? selColor : defaultColor,
            ),
            label: "Home"),
        NavigationDestination(
            icon: Icon(
              Icons.payment_outlined,
              color: widget.currIndex == 1 ? selColor : defaultColor,
            ),
            label: "Pay"),
        NavigationDestination(
            icon: Icon(
              Icons.local_drink,
              color: widget.currIndex == 2 ? selColor : defaultColor,
            ),
            label: "Order"),
        NavigationDestination(
            icon: Icon(
              Icons.more_horiz,
              color: widget.currIndex == 3 ? selColor : defaultColor,
            ),
            label: "Other"),
      ],
    );
  }
}
