import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class MessageCard extends StatelessWidget {
  String? wrappingtype;
  MessageCard({
    super.key,
    this.wrappingtype,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              onError: (_, stack) =>
                  showSnackBarMessage(context, "메세지 카드를 불러오는데 실패했습니다."),
              fit: BoxFit.cover,
              image: AssetImage("assets/img/cards/$wrappingtype.jpg"),
            ),
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 2,
                color: Theme.of(context).colorScheme.shadow.withOpacity(.2),
              ),
            ],
          ),
          width: double.maxFinite,
          height: 150 * getScaleHeight(context),
        ),
        Text(
          "메세지 카드",
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
