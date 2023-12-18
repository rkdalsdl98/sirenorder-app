import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SelectTempture extends StatefulWidget {
  const SelectTempture({
    super.key,
  });

  @override
  State<SelectTempture> createState() => _SelectTemptureState();
}

class _SelectTemptureState extends State<SelectTempture> {
  bool isTemptureHot = true;
  void changeTempture(String value, bool isHot) => setState(() {
        isTemptureHot = isHot;
        context.read<OrderBloc>().add(UpsertDataEvent(
              "tempture",
              isHot ? "HOT" : "COLD",
            ));
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => changeTempture("HOT", true),
            child: Container(
              width: 150 * getScaleWidth(context),
              height: 30 * getScaleHeight(context),
              decoration: BoxDecoration(
                  color: isTemptureHot
                      ? Theme.of(context).colorScheme.error
                      : null,
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.8),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(360),
                    bottomLeft: Radius.circular(360),
                  )),
              child: Center(
                  child: Text(
                "HOT",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 14,
                  color: isTemptureHot
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.8),
                ),
              )),
            ),
          ),
          InkWell(
            onTap: () => changeTempture("COLD", false),
            child: Container(
              width: 150 * getScaleWidth(context),
              height: 30 * getScaleHeight(context),
              decoration: BoxDecoration(
                  color: isTemptureHot
                      ? null
                      : Theme.of(context).colorScheme.primary,
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.8),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(360),
                    bottomRight: Radius.circular(360),
                  )),
              child: Center(
                  child: Text(
                "COLD",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 14,
                  color: isTemptureHot
                      ? Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.8)
                      : Theme.of(context).colorScheme.background,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
