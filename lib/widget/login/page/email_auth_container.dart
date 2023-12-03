import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/regist/event/send_code_event.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';

class EmailAuthContainer extends StatelessWidget {
  final bool authEmail;
  final void Function() publishCode;
  bool readOnly;
  bool showCodeInput;

  EmailAuthContainer({
    super.key,
    required this.authEmail,
    required this.publishCode,
    this.readOnly = false,
    this.showCodeInput = false,
  });

  final TextEditingController _controller = TextEditingController();
  void verifyCode(BuildContext context) {
    final code = _controller.text;
    if (code.isEmpty || code.length != 6) {
      showSnackBarMessage(context, "빈 값 혹은 6자리가 아닙니다.");
      return;
    }

    final bloc = context.read<RegistBloc>();
    bloc.add(SendCodeEvent(code, RequestRoute.code));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      height: 60 * getScaleHeight(context),
      child: authEmail
          ? completeAuthEmail(context)
          : Row(
              mainAxisAlignment: showCodeInput
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (showCodeInput)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 170 * getScaleWidth(context),
                      height: 40 * getScaleHeight(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                            width: 120 * getScaleWidth(context),
                            height: 30 * getScaleHeight(context),
                            child: TextField(
                              readOnly: readOnly,
                              controller: _controller,
                              onSubmitted: (_) {},
                              maxLength: 6,
                              textAlign: TextAlign.center,
                              style: TextStyles.defaultStyle
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "코드를 입력해주세요.",
                                hintStyle: TextStyles.defaultStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => verifyCode(context),
                            child: Text(
                              "인증하기",
                              style: TextStyles.defaultStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 50 * getScaleHeight(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: publishCode,
                          child: Text(
                            "이메일 인증요청",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "인증코드는 대/소문자를 구분합니다.",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Widget completeAuthEmail(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: Checkbox(
      splashRadius: 0,
      value: true,
      activeColor: const Color(0xFF1CBA3E),
      shape: const CircleBorder(),
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      onChanged: (value) {},
      overlayColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const Color(0xFF1CBA3E);
        }
        return Theme.of(context).colorScheme.background;
      }),
    ),
  );
}
