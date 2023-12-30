import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class Counter extends StatefulWidget {
  final void Function() incrementCount;
  final void Function() decrementCount;
  final int count;
  double width;
  double height;
  double buttonSize;
  double fontSize;
  Counter({
    super.key,
    required this.count,
    required this.decrementCount,
    required this.incrementCount,
    this.buttonSize = 24,
    this.fontSize = 24,
    this.height = 30,
    this.width = 100,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: widget.width * getScaleWidth(context),
          height: widget.height * getScaleHeight(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                radius: 0,
                highlightColor: Colors.transparent,
                onTap: widget.count > 1 ? () => widget.decrementCount() : null,
                child: SizedBox(
                  width: widget.buttonSize * getScaleWidth(context),
                  height: widget.buttonSize * getScaleHeight(context),
                  child: Image.asset(
                    widget.count > 1
                        ? "assets/img/minus_active.png"
                        : "assets/img/minus_deactive.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                "${widget.count}",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                radius: 0,
                highlightColor: Colors.transparent,
                onTap: () => widget.incrementCount(),
                child: SizedBox(
                  width: widget.buttonSize * getScaleWidth(context),
                  height: widget.buttonSize * getScaleHeight(context),
                  child: Image.asset(
                    "assets/img/plus.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
