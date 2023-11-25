import 'package:flutter/material.dart';
import 'package:sirenorder_app/widget/login/page/regist/step_one.dart';
import 'package:sirenorder_app/widget/login/page/regist/step_two.dart';

class RegistPage extends StatefulWidget {
  final void Function(int index) onChangePage;

  const RegistPage({
    super.key,
    required this.onChangePage,
  });

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  int step = 0;
  void changeStep(int index) => setState(() {
        step = index;
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 0,
      highlightColor: Theme.of(context).colorScheme.background,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: IndexedStack(
          index: step,
          children: [
            StepOne(
              onChangePage: widget.onChangePage,
              onChangeStep: changeStep,
            ),
            StepTwo(
              onChangePage: widget.onChangePage,
              onChangeStep: changeStep,
            ),
          ],
        ),
      ),
    );
  }
}
