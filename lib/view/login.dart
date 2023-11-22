import 'package:flutter/material.dart';
import 'package:sirenorder_app/widget/login/page/login_page.dart';
import 'package:sirenorder_app/widget/login/page/regist_page.dart';

class Login extends StatefulWidget {
  final int initialPage;
  const Login({
    super.key,
    required this.initialPage,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int currIndex = 0;
  void onChangePage(int index) => setState(() {
        currIndex = index;
      });

  @override
  void initState() {
    super.initState();
    currIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(
          index: currIndex,
          children: [
            LoginPage(onChangePage: onChangePage),
            RegistPage(onChangePage: onChangePage),
          ],
        ),
      ),
    );
  }
}
