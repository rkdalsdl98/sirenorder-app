import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/menuinfo/select_size_button.dart';

class SelectSize extends StatelessWidget {
  final Map<String, String> sizes;
  final int selectSizeIndex;
  final void Function(String, int) onSelectSize;
  const SelectSize({
    super.key,
    required this.sizes,
    required this.selectSizeIndex,
    required this.onSelectSize,
  });

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: double.maxFinite,
      height: 185 * getScaleHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "사이즈",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: sizes.keys.map<SelectSizeButton>(
              (key) {
                ++index;
                return SelectSizeButton(
                  index: index,
                  selectIndex: selectSizeIndex,
                  size: key,
                  volume: sizes[key]!,
                  onSelectSize: onSelectSize,
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
