import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/store/store_list.dart';

class Store extends StatelessWidget {
  Store({super.key});

  StoreModel? selStore;
  void onSelStore(StoreModel store) => selStore = store;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.4),
        width: 0,
      ),
    );
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: InkWell(
          radius: 0,
          highlightColor: Colors.transparent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 타이틀
                  titleHelper(context),
                  // 검색
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: "검색",
                        hintStyle: TextStyles.defaultStyle.copyWith(
                          fontSize: 13,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.2),
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 18 * getScaleWidth(context),
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.4),
                        ),
                        fillColor: const Color(0xFFD9D9D9).withOpacity(.6),
                        filled: true,
                        enabledBorder: border,
                        errorBorder: border,
                        focusedBorder: border,
                        disabledBorder: border,
                        focusedErrorBorder: border,
                      ),
                    ),
                  ),
                  BlocBuilder<StoreBloc, StoreBlocState>(
                    builder: (builderContext, state) {
                      return StoreList(
                        stores: state.stores,
                        onSelStore: onSelStore,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleHelper(BuildContext context) {
    return SizedBox(
      height: 80 * getScaleHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.pop<Map<String, dynamic>?>(
              context,
              selStore?.toJson(),
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
            "매장 설정",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 15,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
