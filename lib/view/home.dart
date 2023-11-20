import 'package:flutter/material.dart';
import 'package:sirenorder_app/widget/common/appmeunbar.dart';
import 'package:sirenorder_app/widget/home/page/home_page.dart';
import 'package:sirenorder_app/widget/home/page/order_page.dart';
import 'package:sirenorder_app/widget/home/page/other_page.dart';
import 'package:sirenorder_app/widget/home/page/pay_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currIndex = 0;
  void onChangeIndex(int value) => setState(() {
        currIndex = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppMenuBar(
        currIndex: currIndex,
        onChangeIndex: onChangeIndex,
      ),
      body: IndexedStack(
        index: currIndex,
        children: const [
          HomePage(),
          PayPage(),
          OrderPage(),
          OtherPage(),
        ],
      ),
    );
  }
}
