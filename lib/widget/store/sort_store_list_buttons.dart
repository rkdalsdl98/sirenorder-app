import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SortStoreListButtons extends StatelessWidget {
  final Function(bool) onChangeList;
  const SortStoreListButtons({
    super.key,
    required this.onChangeList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.maxFinite,
      height: 40 * getScaleHeight(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 130 * getScaleWidth(context),
          child: Row(
            children: [
              InkWell(
                onTap: () => onChangeList(true),
                child: Text(
                  "모든 매장",
                  textAlign: TextAlign.center,
                  style: TextStyles.defaultStyle.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(width: 10 * getScaleWidth(context)),
              Text(
                "|",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5),
                ),
              ),
              SizedBox(width: 10 * getScaleWidth(context)),
              InkWell(
                onTap: () => onChangeList(false),
                child: Text(
                  "영업 중인 매장",
                  textAlign: TextAlign.center,
                  style: TextStyles.defaultStyle.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
