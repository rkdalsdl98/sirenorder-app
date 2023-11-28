import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/bloc/menu_type.dart';
import 'package:sirenorder_app/widget/home/home_appbar_background.dart';

class NewsWrapper extends StatelessWidget {
  const NewsWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      expandedTitleScale: 1,
      centerTitle: true,
      background: const HomeAppBarBackground(),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.maxFinite,
        height: 30 * getScaleHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                context
                    .read<MenuBloc>()
                    .add(GetMenuListEvent(MenuCategory.drink));
              },
              child: SizedBox(
                width: 120 * getScaleWidth(context),
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage("assets/img/email.png"),
                      width: 30 * getScaleWidth(context),
                      height: 22.8 * getScaleHeight(context),
                    ),
                    SizedBox(width: 10 * getScaleWidth(context)),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        "What’s New?",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.notifications_none,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }
}
