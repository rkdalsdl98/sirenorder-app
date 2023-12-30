import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/event/register_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';

class CouponRegister extends StatelessWidget {
  CouponRegister({
    super.key,
  });

  final TextEditingController _controller = TextEditingController();

  bool _validate(BuildContext context, String? code) {
    if (code == null || code.isEmpty) {
      showSnackBarMessage(context, "쿠폰번호를 입력해주세요.");
      return false;
    } else if (code.length != 12) {
      showSnackBarMessage(context, "쿠폰번호 12자리를 입력해주세요.");
      return false;
    }
    return true;
  }

  void registerCoupon(BuildContext context) {
    final code = _controller.text;
    if (!_validate(context, code)) return;
    final userBloc = context.read<UserBloc>();
    final user = userBloc.state.user!;
    FocusScope.of(context).unfocus();
    _controller.clear();

    userBloc.add(RegisterCouponEvent(user.email!, code));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * getScaleHeight(context),
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: Theme.of(context).shadowColor.withOpacity(.1),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 80 * getScaleHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "발급받은 쿠폰이 있다면 여기에 입력해주세요!",
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                SizedBox(
                  width: 200 * getScaleWidth(context),
                  child: TextField(
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    controller: _controller,
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: "쿠폰번호 입력",
                      hintStyle: TextStyles.defaultStyle.copyWith(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(.8),
                        fontWeight: FontWeight.w700,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30 * getScaleHeight(context),
            child: RoundedButtonMedium(
              text: "쿠폰등록",
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              textColor: Theme.of(context).colorScheme.background,
              onTab: () => registerCoupon(context),
            ),
          ),
        ],
      ),
    );
  }
}
