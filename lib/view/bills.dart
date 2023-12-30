import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/bill/biil_item.dart';

class Bills extends StatelessWidget {
  const Bills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: double.maxFinite,
            height: 60 * getScaleHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop<Map<String, dynamic>?>(
                    context,
                  ),
                  child: Container(
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
                const Spacer(),
                Text(
                  "구매내역",
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          BlocBuilder<UserBloc, UserBlocState>(builder: (blocContext, state) {
            final histories = state.user!.orderhistory ?? [];
            return histories.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: histories
                            .map<BillItem>(
                                (history) => BillItem(history: history))
                            .toList(),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("구매내역이 없습니다."),
                  );
          })
        ],
      ),
    );
  }
}
