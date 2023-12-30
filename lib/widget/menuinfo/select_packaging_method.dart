import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

const Map<int, dynamic> comments = {
  1: {
    "comment":
        "* 주문 후, 개인컵(887ml 이상, 텀블러 등)을 '음료 받는 곳'에 전달해 주세요.\n* 개인컵은 다회용기(텀블러, 머그 등)만 사용 가능하며 1회용기에는 음료 제공이 불가합니다.\n* 개인컵을 선택한 경우 일회용 리드는 제공되지 않습니다.\n* 개인컵이 전달되지 않거나 전달된 개인컵이 주문한 음료를 담기 어려울 경우(용량 미달, 좁은 투입구 등) 주문이 거절될 수 있습니다.\n* 차량에서 음료를 픽업하는 경우 개인컵 이용시에는 리드(뚜껑)을 파트너에게 함께 전달하여 주세요.",
    "height": 260,
  },
  2: {
    "comment": "매장에서 드시는 경우 일회용컵 사용이 불가능합니다.\n개인컵 또는 매장컵을 선택해 주시기 바랍니다.",
    "height": 150,
  },
};

class SelectPackagingMethod extends StatefulWidget {
  const SelectPackagingMethod({
    super.key,
  });

  @override
  State<SelectPackagingMethod> createState() => _SelectPackagingMethodState();
}

class _SelectPackagingMethodState extends State<SelectPackagingMethod> {
  List<String> packagingMethods = ["매장컵", "개인컵", "일회용컵"];
  int selectIndex = -1;
  int wrapHeight = 100;

  void changeMethod(int index) => setState(() {
        selectIndex = index;
        if (comments[selectIndex] == null) {
          wrapHeight = 100;
        } else {
          wrapHeight = comments[selectIndex]['height'];
        }
        context.read<OrderBloc>().add(UpsertDataEvent(
              "packagingMethod",
              packagingMethods[selectIndex],
            ));
      });
  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
      ),
      width: double.maxFinite,
      height: wrapHeight * getScaleHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "컵 선택",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: packagingMethods.map<Widget>((text) {
                ++index;
                return methodHelper(
                  context,
                  index: index,
                  text: text,
                );
              }).toList(),
            ),
          ),
          if (comments[selectIndex] != null)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.maxFinite,
              color: const Color(0xFFD9D9D9).withOpacity(.6),
              child: Text(
                comments[selectIndex]['comment'],
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget methodHelper(
    BuildContext context, {
    required int index,
    required String text,
  }) {
    return InkWell(
      onTap: () => changeMethod(index),
      child: Container(
        width: 100 * getScaleWidth(context),
        height: 40 * getScaleHeight(context),
        decoration: BoxDecoration(
          color: selectIndex == index
              ? const Color.fromARGB(255, 20, 131, 44)
              : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 14,
              fontWeight: selectIndex == index ? FontWeight.w500 : null,
              color: selectIndex == index
                  ? Theme.of(context).colorScheme.background
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
