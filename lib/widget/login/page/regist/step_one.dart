import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/regist/event/clear_event.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/login/page/regist/double_check_box.dart';
import 'package:sirenorder_app/widget/login/page/regist/one_check_box.dart';
import 'package:sirenorder_app/widget/login/page/regist/step_header.dart';

class StepOne extends StatefulWidget {
  final void Function(int index) onChangePage;
  final void Function(int index) onChangeStep;

  const StepOne({
    super.key,
    required this.onChangePage,
    required this.onChangeStep,
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
  bool allDoubleCheck = false;

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
      if (allCheck) {
        (checks[0] as OneCheckState).setCheckState(false);
        allCheck = false;
      }
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
      allDoubleCheck = value;
      (checks[key] as DoubleCheckState).setAllCheckState(value);
    });
  }

  bool _checkRequiedCheck() {
    bool result = true;
    for (var key in checks.keys) {
      if (key == 0) continue;
      if (checks[key] is OneCheckState) {
        if (!(checks[key] as OneCheckState).state) {
          result = false;
          break;
        }
      }
    }

    return !result;
  }

  void exit() {
    final bloc = context.read<RegistBloc>();
    bloc.add(ClearEvent());
    widget.onChangePage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepHeader(
          onTab: exit,
          title: "회원가입",
          subTitle: "사이렌 오더 회원이 아니시군요?",
          comment: "사이렌 오더 아이디를 생성하시면\n다양한 혜택을 함께 누릴 수 있습니다!",
        ),
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
                    currAllState: allDoubleCheck,
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
            disabled: _checkRequiedCheck(),
            text: "다음",
            fontSize: 14,
            onTab: () {
              allChangeState(false, null);
              changeAllDoubleCheckState(false, checks.length - 1);
              widget.onChangeStep(1);
            },
          ),
        )
      ],
    );
  }
}
