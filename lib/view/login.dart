import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
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
      child: BlocProvider(
        create: (blocContext) => RegistBloc(blocContext.read<UserRepository>()),
        child: Scaffold(
          body: IndexedStack(
            index: currIndex,
            children: [
              BlocBuilder<UserBloc, UserBlocState>(builder: (_, state) {
                return LoginPage(
                  onChangePage: onChangePage,
                  state: state,
                );
              }),
              RegistPage(onChangePage: onChangePage),
            ],
          ),
        ),
      ),
    );
  }
}
