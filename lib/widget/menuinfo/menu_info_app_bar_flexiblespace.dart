import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class MenuInfoAppBarFlexibleSpace extends StatelessWidget {
  final String menuname;
  final bool pinned;
  String? thumbnail;

  MenuInfoAppBarFlexibleSpace({
    super.key,
    required this.pinned,
    required this.menuname,
    this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      expandedTitleScale: 1,
      titlePadding: EdgeInsets.zero,
      title: pinned
          ? isPinned(
              context,
              menuname,
            )
          : isNotPinned(
              context,
              menuname,
            ),
      background: thumbnail != null
          ? Image.network(
              thumbnail!,
              fit: BoxFit.cover,
            )
          : Center(
              child: Text(
                "미리보기 이미지가 없는 메뉴입니다.",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}

Widget isPinned(BuildContext context, String text) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.outline.withOpacity(.5),
        width: .8,
      ),
    )),
    margin: const EdgeInsets.only(bottom: 15),
    width: double.maxFinite,
    height: 20 * getScaleHeight(context),
    child: Center(
      child: Text(
        text,
        style: TextStyles.titleStyle.copyWith(
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget isNotPinned(BuildContext context, String text) {
  return Container(
    padding: const EdgeInsets.only(top: 15),
    width: double.maxFinite,
    color: Theme.of(context).colorScheme.background,
    margin: const EdgeInsets.only(left: 15),
    height: 40 * getScaleHeight(context),
    child: Text(
      text,
      style: TextStyles.titleStyle.copyWith(
        fontSize: 20,
      ),
    ),
  );
}
