import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/common/validation.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/common/input_form.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/gift/preview_card.dart';
import 'package:sirenorder_app/widget/gift/selected_menus.dart';

class Gift extends StatefulWidget {
  final Map<String, dynamic> json;
  final int amount;
  final String type;

  const Gift({
    super.key,
    required this.json,
    required this.amount,
    required this.type,
  });

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> result = {};
  bool isLoading = false;
  int cardNum = 1;

  void onUpdateResult(String key, dynamic data) {
    result.update(
      key,
      (_) => data,
      ifAbsent: () => data,
    );
  }

  void onChangeCard(int num) => setState(() {
        cardNum = num;
      });

  void payment() {
    final form = _formkey.currentState;

    if (form == null) {
      showSnackBarMessage(
        context,
        "알 수 없는 오류로 결제를 할 수 없습니다.\n해당 페이지를 닫은 이후에 다시 시도해주세요.",
      );
      return;
    }

    final validate = form.validate();
    if (!validate) {
      return;
    }
    form.save();

    final bloc = context.read<UserBloc>();
    final user = bloc.state.user!;
    final MenuModel menu = MenuModel.fromJson(widget.json);

    final order = OrderModel(
      menu.name,
      user.tel!,
      user.email!,
      user.nickname!,
      PaymentCustomData.fromJson({
        "type": widget.type,
        "data": {
          "giftInfo": {
            "from": result["to"],
            "to": user.email,
            "wrappingtype": "card$cardNum",
            "menu": menu,
            "message": result["message"],
          }
        }
      }),
      widget.amount,
    );

    Navigator.pushNamed(
      context,
      "/payment",
      arguments: {
        "order": order.toJson(),
        "type": widget.type,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => isLoading ? null : Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(top: 35),
                    padding: const EdgeInsets.only(left: 10),
                    width: 25 * getScaleWidth(context),
                    height: 25 * getScaleHeight(context),
                    child: Text(
                      "<",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 22,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  height: 100 * getScaleHeight(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "선물하기",
                        style: TextStyles.titleStyle,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "선물을 위한 간단한 정보를 입력하고,\n커피한잔으로 여러분의 마음을 전해보세요!",
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
                PreviewCard(
                  num: cardNum,
                  onChangeCard: onChangeCard,
                  isLoading: isLoading,
                ),
                SizedBox(height: 10 * getScaleHeight(context)),
                InputForm(
                  formKey: _formkey,
                  fields: const {
                    "message": {
                      "hint": "전하고 싶은 메세지 (20자이내)",
                      "max_length": 20,
                    },
                    "to": {
                      "hint": "선물을 전달할 고객님의 이메일",
                      "type": ValidateType.email,
                    }
                  },
                  onUpdateResult: onUpdateResult,
                ),
                SizedBox(height: 10 * getScaleHeight(context)),
                SelectedMenus(isLoading: isLoading),
                SizedBox(height: 10 * getScaleHeight(context)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: RichText(
                    text: TextSpan(
                      text: "* 결제하기 전에 선택한 상품이 맞는지 반드시 확인하고 결제해주세요!\n",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                      children: const [
                        TextSpan(text: "* 결제한 상품은 전달받은 상대만 취소가 가능합니다.\n"),
                        TextSpan(text: "* 최종 결제금액은 하단에 표기되니 참고해주세요."),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
                  width: double.maxFinite,
                  height: 60 * getScaleHeight(context),
                  child: RoundedButtonSmall(
                    disabled: isLoading,
                    text: "${addComma(widget.amount)} 원 결제하기",
                    fontSize: 14,
                    onTab: payment,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
