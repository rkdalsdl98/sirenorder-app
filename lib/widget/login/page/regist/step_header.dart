import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class StepHeader extends StatelessWidget {
  final void Function() onTab;
  final String title;
  final String subTitle;
  final String comment;

  const StepHeader({
    super.key,
    required this.onTab,
    required this.title,
    required this.subTitle,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTab,
          child: Container(
            margin: const EdgeInsets.only(top: 35),
            padding: const EdgeInsets.only(left: 10),
            width: 25 * getScaleWidth(context),
            height: 25 * getScaleHeight(context),
            child: Text(
              "<",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 22,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.maxFinite,
          height: 145 * getScaleHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.titleStyle,
              ),
              const Spacer(),
              Text(
                subTitle,
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  comment,
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        SizedBox(height: 40 * getScaleHeight(context)),
      ],
    );
  }
}
