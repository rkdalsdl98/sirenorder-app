import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/type/check_state.dart';

class OneCheckBox extends StatelessWidget {
  final void Function(bool value, int key) onChangeState;
  final OneCheckState state;
  final int index;

  const OneCheckBox({
    super.key,
    required this.state,
    required this.index,
    required this.onChangeState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: index == 0
            ? Border(
                bottom: BorderSide(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.5)),
              )
            : null,
      ),
      width: double.maxFinite,
      height: 40 * getScaleHeight(context),
      child: Row(
        children: [
          Checkbox(
            value: state.state,
            activeColor: const Color(0xFF1CBA3E),
            shape: const CircleBorder(),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            onChanged: (value) {
              if (value != null) {
                onChangeState(value, index);
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
            state.text,
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
