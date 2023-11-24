import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class DoubleCheckBox extends StatefulWidget {
  final DoubleCheckState state;
  final int index;
  final void Function(bool value, int key, DoubleCheckOrder order)
      onChangeState;
  final void Function(bool value, int key) onChangeAllState;
  bool currAllState;

  DoubleCheckBox({
    super.key,
    required this.state,
    required this.index,
    required this.onChangeState,
    required this.onChangeAllState,
    this.currAllState = false,
  });

  @override
  State<DoubleCheckBox> createState() => _DoubleCheckBoxState();
}

class _DoubleCheckBoxState extends State<DoubleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 105 * getScaleHeight(context),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.currAllState,
                activeColor: const Color(0xFF1CBA3E),
                shape: const CircleBorder(),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                onChanged: (value) {
                  if (value != null) {
                    widget.currAllState = value;
                    widget.onChangeAllState(value, widget.index);
                  }
                },
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF1CBA3E);
                  }
                  return Theme.of(context).colorScheme.background;
                }),
              ),
              Text(
                widget.state.text,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 35),
            width: double.maxFinite,
            height: 50 * getScaleHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 15),
                  child: Text(
                    widget.state.text,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20 * getScaleHeight(context),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: .8,
                            child: Checkbox(
                              value:
                                  widget.state.states[DoubleCheckOrder.first],
                              activeColor: const Color(0xFF1CBA3E),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  widget.onChangeState(value, widget.index,
                                      DoubleCheckOrder.first);
                                }
                              },
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xFF1CBA3E);
                                }
                                return Theme.of(context).colorScheme.background;
                              }),
                            ),
                          ),
                          Text(
                            "E-mail",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20 * getScaleHeight(context),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: .8,
                            child: Checkbox(
                              value:
                                  widget.state.states[DoubleCheckOrder.second],
                              activeColor: const Color(0xFF1CBA3E),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  widget.onChangeState(value, widget.index,
                                      DoubleCheckOrder.second);
                                }
                              },
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xFF1CBA3E);
                                }
                                return Theme.of(context).colorScheme.background;
                              }),
                            ),
                          ),
                          Text(
                            "SMS",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
