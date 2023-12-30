import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/gift/preview_card_icon.dart';

class PreviewCard extends StatelessWidget {
  final int num;
  final void Function(int num) onChangeCard;
  bool isLoading;

  PreviewCard({
    super.key,
    required this.num,
    required this.onChangeCard,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 270 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            height: 60 * getScaleHeight(context),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [1, 2, 3]
                    .map<Widget>((e) => PreviewCardIcon(
                          num: e,
                          onChangeCard: onChangeCard,
                          isLoading: isLoading,
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/img/cards/card$num.jpg"),
                opacity: isLoading ? .25 : 1,
              ),
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 8),
                  blurRadius: 2,
                  color: Theme.of(context)
                      .colorScheme
                      .shadow
                      .withOpacity(isLoading ? 0 : .2),
                ),
              ],
            ),
            width: 200 * getScaleWidth(context),
            height: 200 * getScaleHeight(context),
          ),
        ],
      ),
    );
  }
}
