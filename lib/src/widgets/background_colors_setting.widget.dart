import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_touch/src/classes/gradient_color.dart';
import 'package:flutter_multi_touch/src/themes/colors.dart';
import 'package:flutter_multi_touch/src/widgets/title_setting_section.widget.dart';

import '../constants/constant.dart';

class BackgroundColorsSetting extends StatefulWidget {
  const BackgroundColorsSetting({
    this.selectedColor,
    required this.onSelectColor,
  });
  final BackgroundColor? selectedColor;
  final Function(BackgroundColor?) onSelectColor;

  @override
  State<BackgroundColorsSetting> createState() =>
      _BackgroundColorsSettingState();
}

class _BackgroundColorsSettingState extends State<BackgroundColorsSetting> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSection(title: "Solid colors"),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              _ColorItem(
                isSelected: widget.selectedColor == null,
                onSelectColor: (_) => widget.onSelectColor(null),
              ),
              ...ColorStyles.backgroundSolidColors.map((e) {
                final _color = BackgroundColor(startColor: e);
                return _ColorItem(
                  color: BackgroundColor(startColor: e),
                  isSelected: widget.selectedColor == _color,
                  onSelectColor: widget.onSelectColor,
                );
              }).toList(),
            ],
          ),
          TitleSection(title: "Gradient colors"),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              ...ColorStyles.backgroundGradientColors.map((e) {
                final _color = BackgroundColor(
                  startColor: e.$1,
                  endColor: e.$2,
                );
                return _ColorItem(
                  color: _color,
                  isSelected: widget.selectedColor == _color,
                  onSelectColor: widget.onSelectColor,
                );
              }).toList()
            ],
          ),
          TitleSection(title: "Gradient colors"),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              ...ColorStyles.backgroundGradientColors.map((e) {
                final _color = BackgroundColor(
                  startColor: e.$1,
                  endColor: e.$2,
                );
                return _ColorItem(
                  color: _color,
                  isSelected: widget.selectedColor == _color,
                  onSelectColor: widget.onSelectColor,
                );
              }).toList()
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    Key? key,
    this.color,
    this.isSelected = false,
    required this.onSelectColor,
  }) : super(key: key);
  final BackgroundColor? color;
  final bool isSelected;
  final Function(BackgroundColor?) onSelectColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectColor(color),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color?.startColor,
          border: Border.all(color: ColorStyles.black3),
          image: color == null
              ? DecorationImage(image: NetworkImage(transparentImg))
              : null,
          gradient: color?.isGradientColor ?? false
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [color!.startColor!, color!.endColor!],
                )
              : null,
        ),
        width: 40,
        height: 40,
        child: isSelected
            ? Center(
                child: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: ColorStyles.white,
                ),
              )
            : null,
      ),
    );
  }
}
