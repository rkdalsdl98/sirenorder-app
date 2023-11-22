import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/login/page/regist/double_check_box.dart';
import 'package:sirenorder_app/widget/login/page/regist/one_check_box.dart';

class StepOne extends StatefulWidget {
  final void Function(int index) onChangePage;

  const StepOne({
    super.key,
    required this.onChangePage,
  });

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final Map<int, CheckState> checks = {
    0: OneCheckState("필수약관 전체동의"),
    1: OneCheckState("이용약관 동의(필수)"),
    2: OneCheckState("개인정보 수집 및 이용동의(필수)"),
    3: DoubleCheckState("광고성 정보 수신동의(모두 선택)"),
  };
  bool allCheck = false;

  void allChangeState(bool value, int? key) {
    setState(() {
      for (var e in checks.keys) {
        checks.update(e, (prev) {
          if (prev is OneCheckState) {
            prev.setCheckState(value);
          } else if (prev is DoubleCheckState) {
            prev.states.updateAll((key, value) => value);
          }
          return prev;
        });
      }
      allCheck = value;
    });
  }

  void changeOneCheckState(bool value, int key) {
    setState(() {
      (checks[key] as OneCheckState).setCheckState(value);
    });
  }

  void changeDoubleCheckState(bool value, int key, DoubleCheckOrder order) {
    setState(() {
      (checks[key] as DoubleCheckState).setCheckState(order, value);
    });
  }

  void changeAllDoubleCheckState(bool value, int key) {
    setState(() {
      (checks[key] as DoubleCheckState).setAllCheckState(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget.onChangePage(0);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 35),
            padding: const EdgeInsets.only(left: 10),
            width: 25 * getScaleWidth(context),
            height: 25 * getScaleHeight(context),
            child: Text(
              "<",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 22,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.5),
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
                "회원가입",
                style: TextStyles.titleStyle,
              ),
              const Spacer(),
              Text(
                "사이렌 오더 회원이 아니시군요?",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "사이렌 오더 아이디를 생성하시면\n다양한 혜택을 함께 누릴 수 있습니다!",
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
        SizedBox(height: 40 * getScaleHeight(context)),
        SizedBox(
          width: double.maxFinite,
          height: 300 * getScaleHeight(context),
          child: Column(
            children: checks.keys.map<Widget>(
              (key) {
                if (checks[key] is OneCheckState) {
                  return OneCheckBox(
                    index: key,
                    state: checks[key] as OneCheckState,
                    onChangeState:
                        key == 0 ? allChangeState : changeOneCheckState,
                  );
                } else {
                  return DoubleCheckBox(
                    index: key,
                    state: checks[key] as DoubleCheckState,
                    onChangeState: changeDoubleCheckState,
                    onChangeAllState: changeAllDoubleCheckState,
                  );
                }
              },
            ).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
          width: double.maxFinite,
          height: 60 * getScaleHeight(context),
          child: RoundedButtonSmall(
            text: "다음",
            fontSize: 14,
            onTab: () {},
          ),
        )
      ],
    );
  }
}
