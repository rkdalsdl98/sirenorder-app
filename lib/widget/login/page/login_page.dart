import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/input_form.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/common/validation.dart';
import 'package:sirenorder_app/widget/login/page/regist/finders.dart';

class LoginPage extends StatelessWidget {
  final void Function(int index) onChangePage;

  LoginPage({
    super.key,
    required this.onChangePage,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> result = {};

  void login(BuildContext context) {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;
    if (form == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("알 수 없는 오류가 발생했습니다.\n앱을 재실행해 주세요."),
        ),
      );
      return;
    }

    final bool validate = form.validate();
    if (!validate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("입력하신 정보를 한번 더 확인해주세요."),
        ),
      );
      return;
    }

    form.save();
  }

  void updateResult(String key, dynamic data) {
    result.update(
      key,
      (value) => data,
      ifAbsent: () => data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 0,
      highlightColor: Theme.of(context).colorScheme.background,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
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
              height: 145 * getScaleHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "로그인",
                    style: TextStyles.titleStyle,
                  ),
                  const Spacer(),
                  Text(
                    "안녕하세요!",
                    style: TextStyles.titleStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "다양한 혜택과 회원전용 서비스 사용을\n위해 로그인 하시겠어요?",
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
            SizedBox(height: 80 * getScaleHeight(context)),
            SizedBox(
              width: double.maxFinite,
              height: 320 * getScaleHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputForm(
                    formKey: _formKey,
                    fields: const {
                      "email": {
                        "hint": "이메일을 입력해주세요.",
                        "type": ValidateType.email,
                      },
                      "pass": {
                        "hint": "비밀번호를 입력해주세요.",
                        "obscure": true,
                        "type": ValidateType.pass,
                      }
                    },
                    onUpdateResult: updateResult,
                  ),
                  SizedBox(height: 15 * getScaleHeight(context)),
                  Finders(
                    onChangePage: onChangePage,
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 25),
                    width: double.maxFinite,
                    height: 60 * getScaleHeight(context),
                    child: RoundedButtonSmall(
                      text: "로그인하기",
                      fontSize: 14,
                      onTab: () {
                        login(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
