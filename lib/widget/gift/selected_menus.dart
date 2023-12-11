import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/gift/selected_menu_item.dart';

class SelectedMenus extends StatelessWidget {
  bool isLoading;
  SelectedMenus({
    super.key,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200 * getScaleHeight(context),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: SizedBox(
              width: 100 * getScaleWidth(context),
              height: 200 * getScaleHeight(context),
              child: PageView(
                pageSnapping: false,
                children: [
                  SelectedMenuItem(isLoading: isLoading),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "<",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: TextButton(
              onPressed: () {},
              child: Text(
                ">",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
