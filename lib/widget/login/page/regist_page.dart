import 'package:flutter/material.dart';
import 'package:sirenorder_app/widget/login/page/regist/step_one.dart';

class RegistPage extends StatelessWidget {
  final void Function(int index) onChangePage;

  const RegistPage({
    super.key,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StepOne(onChangePage: onChangePage),
    );
  }
}
