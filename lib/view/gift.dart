import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
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
import 'package:sirenorder_app/widget/gift/selected_gift.dart';

class Gift extends StatefulWidget {
  final Map<String, dynamic> json;
  final String type;

  const Gift({
    super.key,
    required this.json,
    required this.type,
  });

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  late final MenuModel menu;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> result = {};
  bool isLoading = true;
  bool isInitialized = false;
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
    } else if (!form.validate()) {
      return;
    }
    form.save();

    final bloc = context.read<UserBloc>();
    final user = bloc.state.user!;

    // if (result["to"] == user.email) {
    //   showSnackBarMessage(
    //     context,
    //     "자신에게는 선물을 보낼 수 없습니다.",
    //   );
    //   return;
    // }
    final OrderModel order = createOrder();
    Navigator.pushNamed(
      context,
      "/payment",
      arguments: {
        "order": order.toJson(),
        "type": widget.type,
      },
    );
  }

  OrderModel createOrder() {
    final amount = context.read<MenuBloc>().state.detail!.price * menu.count;
    final user = context.read<UserBloc>().state.user!;
    final message = (result["message"] == "" || result["message"] == null)
        ? "고마음이 가득 담긴 선물"
        : result["message"];
    final customData = PaymentCustomData.fromJson({
      "type": "gift",
      "data": {
        "giftInfo": {
          "from": user.email,
          "to": result["to"],
          "message": message,
          "wrappingtype": "card$cardNum",
          "menu": menu,
        },
      },
    });
    return OrderModel.fromJson({
      "name": menu.name,
      "buyer_tel": user.tel!,
      "buyer_email": user.email!,
      "buyer_name": user.nickname!,
      "custom_data": customData.toJson(),
      "amount": amount,
    });
  }

  @override
  void initState() {
    super.initState();
    menu = MenuModel.fromJson(widget.json);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: BlocBuilder<MenuBloc, MenuBlocState>(
              builder: (builderContext, state) {
            if (state.detail == null && !isInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                builderContext
                    .read<MenuBloc>()
                    .add(GetMenuDetailEvent(menu.detailId));
              });
            }
            if (state is! MenuBlocLoadingState) {
              isLoading = false;
            } else {
              isLoading = true;
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 뒤로가기
                      InkWell(
                        onTap: () => Navigator.pop(builderContext),
                        child: Container(
                          margin: const EdgeInsets.only(top: 35),
                          padding: const EdgeInsets.only(left: 10),
                          width: 25 * getScaleWidth(builderContext),
                          height: 25 * getScaleHeight(builderContext),
                          child: Text(
                            "<",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 22,
                              color: Theme.of(builderContext)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                      // 헤더
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.maxFinite,
                        height: 100 * getScaleHeight(builderContext),
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
                      // 카드 선택
                      PreviewCard(
                        num: cardNum,
                        onChangeCard: onChangeCard,
                      ),
                      SizedBox(height: 10 * getScaleHeight(context)),
                      // 정보 입력
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
                      SizedBox(height: 10 * getScaleHeight(builderContext)),
                      // 메뉴 정보
                      SelectedGift(
                        menuname: menu.name,
                        price: state.detail?.price,
                        thumbnail: menu.thumbnail,
                      ),
                      SizedBox(height: 10 * getScaleHeight(builderContext)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        width: double.maxFinite,
                        height: 60 * getScaleHeight(builderContext),
                        child: RoundedButtonSmall(
                          text: "${addComma(state.detail?.price ?? 0)} 원 결제하기",
                          fontSize: 14,
                          onTab: payment,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLoading) const LoadingIndicator(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
