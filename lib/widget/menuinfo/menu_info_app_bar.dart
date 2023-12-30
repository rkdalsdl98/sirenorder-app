import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/menuinfo/menu_info_app_bar_flexiblespace.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class MenuInfoAppBar extends StatelessWidget {
  String? menuname;
  String? thumbnail;
  MenuInfoAppBar({
    super.key,
    required double toolbarHeight,
    required double expandedHeight,
    required this.isPinned,
    this.thumbnail,
    this.menuname,
  })  : _toolbarHeight = toolbarHeight,
        _expandedHeight = expandedHeight;

  final double _toolbarHeight;
  final double _expandedHeight;
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      pinned: true,
      toolbarHeight: _toolbarHeight * getScaleHeight(context),
      expandedHeight: _expandedHeight * getScaleHeight(context),
      elevation: 0,
      flexibleSpace: MenuInfoAppBarFlexibleSpace(
        pinned: isPinned,
        menuname: menuname ?? "",
        thumbnail: thumbnail,
      ),
      leading: Container(
        padding: const EdgeInsets.only(left: 10),
        width: 25 * getScaleWidth(context),
        height: 25 * getScaleHeight(context),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          radius: 0,
          highlightColor: Colors.transparent,
          child: Text(
            "<",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
