import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/regist/event/create_user_event.dart';
import 'package:sirenorder_app/bloc/regist/event/publish_code_event.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc_state.dart';
import 'package:sirenorder_app/common/validation.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/input_form.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/login/page/email_auth_container.dart';
import 'package:sirenorder_app/widget/login/page/regist/step_header.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class StepTwo extends StatefulWidget {
  final void Function(int index) onChangeStep;
  final void Function(int index) onChangePage;

  const StepTwo({
    super.key,
    required this.onChangeStep,
    required this.onChangePage,
  });

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> result = {};
  bool isAlertError = false;

  void prev() {
    final form = _formKey.currentState;
    if (form != null) {
      form.reset();
    }
    result = {};

    widget.onChangeStep(0);
  }

  void updateResult(String key, dynamic data) {
    result.update(
      key,
      (_) => data,
      ifAbsent: () => data,
    );
  }

  void resetRegistData() {
    result = {};
    widget.onChangeStep(0);
    widget.onChangePage(0);
  }

  FormState? getForm() {
    final form = _formKey.currentState;
    if (form == null) {
      return null;
    } else if (!form.validate()) {
      return null;
    }

    form.save();
    return form;
  }

  void publishCode() {
    FocusScope.of(context).unfocus();
    final form = getForm();
    if (form == null || result.isEmpty) {
      return;
    }

    final bloc = context.read<RegistBloc>();
    bloc.add(PublishCodeEvent(RequestRoute.publishcode, result));
  }

  void registUser() {
    final String email = result['email'];
    final bloc = context.read<RegistBloc>();
    bloc.add(CreateUserEvent(email));
  }

  done() {
    showDialog(
      context: context,
      builder: (builderContext) => AlertDialog(
        content: SizedBox(
          height: 150 * getScaleHeight(builderContext),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "사이렌 오더와\n함께해주셔서 감사합니다!",
                textAlign: TextAlign.center,
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10 * getScaleHeight(context)),
              Text(
                "다양한 이벤트와 혜택을 받으실 수 있어요!\n(수신방법은 계정관리탭에서 수정이 가능합니다.)",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 10,
                  height: 1.8,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 80 * getScaleWidth(builderContext),
                height: 30 * getScaleHeight(builderContext),
                child: RoundedButtonSmall(
                  text: "확인",
                  fontSize: 12,
                  onTab: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/",
                    (_) => false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistBloc, RegistBlocState>(
        builder: (blocContext, state) {
      final isLoading = (state is RegistBlocLoadingState);
      if (state is RegistBlocErrorState) {
        if (!isAlertError) {
          print(state.exception.type);
          showSnackBarMessage(context, state.exception.message);
        }
      } else if (state is RegistBlocLoadedState) {
        isAlertError = false;
      } else if (state is RegistBlocCreatedState) {
        isAlertError = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          done();
        });
      }
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepHeader(
                onTab: prev,
                title: "회원가입",
                subTitle: "마지막 이에요!",
                comment: "사이렌 오더에서 사용하실 이메일과\n비밀번호, 별명을 입력해주세요.",
              ),
              SizedBox(
                width: double.maxFinite,
                height: 300 * getScaleHeight(context),
                child: Column(
                  children: [
                    InputForm(
                      readOnly: state.authEmail,
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
                        },
                        "nickname": {
                          "hint": "별명을 입력해주세요.",
                          "type": ValidateType.nickname,
                        }
                      },
                      onUpdateResult: updateResult,
                    ),
                    EmailAuthContainer(
                      authEmail: state.authEmail,
                      readOnly: (state is RegistBlocLoadingState),
                      showCodeInput: state.pulishCode,
                      publishCode: publishCode,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
                width: double.maxFinite,
                height: 60 * getScaleHeight(context),
                child: RoundedButtonSmall(
                  text: "만들기",
                  fontSize: 14,
                  onTab: registUser,
                  isLoading: isLoading,
                  disabled: !state.authEmail,
                ),
              )
            ],
          ),
          if (isLoading) const LoadingIndicator(),
        ],
      );
    });
  }
}
