import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';

class PreviewCardIcon extends StatelessWidget {
  final int num;
  final void Function(int num) onChangeCard;
  bool isLoading;

  PreviewCardIcon({
    super.key,
    required this.num,
    required this.onChangeCard,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isLoading ? null : onChangeCard(num),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 50 * getScaleWidth(context),
        height: 50 * getScaleHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: isLoading ? .25 : 1,
            image: AssetImage("assets/img/cards/card$num.jpg"),
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 2,
              color: Theme.of(context)
                  .colorScheme
                  .shadow
                  .withOpacity(isLoading ? 0 : .2),
            ),
          ],
        ),
      ),
    );
  }
}
