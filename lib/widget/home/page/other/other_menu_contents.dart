import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/other_menu_content.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class OtherMenuContents extends StatelessWidget {
  final String menuname;
  final List<OtherMenuContent> contents;

  const OtherMenuContents({
    super.key,
    required this.contents,
    required this.menuname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.25),
          ),
        ),
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            menuname,
            style: TextStyles.titleStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5 * getScaleHeight(context)),
          Column(
            children: wrapContentHelper(context, contents),
          ),
        ],
      ),
    );
  }
}

List<Widget> wrapContentHelper(
    BuildContext context, List<OtherMenuContent> contents) {
  List<Widget> wrapped = [];
  List<Widget> row = [];
  double iconSize = 40;
  for (var content in contents) {
    if (row.length >= 2) {
      wrapped.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row,
        ),
      ));
      row = [];
    }
    row.add(InkWell(
      onTap: content.onTab,
      child: Row(
        children: [
          Image.asset(
            content.imageUrl,
            width: iconSize * getScaleWidth(context),
            height: iconSize * getScaleHeight(context),
          ),
          Text(
            content.text,
            style: TextStyles.defaultStyle,
          ),
        ],
      ),
    ));
  }

  if (row.isNotEmpty) {
    wrapped.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: row,
      ),
    ));
  }

  return wrapped;
}
