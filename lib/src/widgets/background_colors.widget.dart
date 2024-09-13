import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_touch/src/themes/colors.dart';

class BackgroundColorsSetting extends StatefulWidget {
  const BackgroundColorsSetting({
    this.selectedColor,
    required this.onSelectColor,
  });
  final (Color?, Color?)? selectedColor;
  final Function((Color?, Color?)?) onSelectColor;

  @override
  State<BackgroundColorsSetting> createState() =>
      _BackgroundColorsSettingState();
}

class _BackgroundColorsSettingState extends State<BackgroundColorsSetting> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleSection(title: "Solid colors"),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                _ColorItem(
                  isSelected: widget.selectedColor == null,
                  onSelectColor: (_) => widget.onSelectColor(null),
                ),
                ...ColorStyles.backgroundSolidColors
                    .map((e) => _ColorItem(
                          color$1: e,
                          isSelected: widget.selectedColor?.$1 == e &&
                              widget.selectedColor?.$2 == null,
                          onSelectColor: widget.onSelectColor,
                        ))
                    .toList(),
              ],
            ),
            _TitleSection(title: "Gradient colors"),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                ...ColorStyles.backgroundGradientColors
                    .map((e) => _ColorItem(
                          color$1: e.$1,
                          color$2: e.$2,
                          isSelected: widget.selectedColor == e,
                          onSelectColor: widget.onSelectColor,
                        ))
                    .toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    Key? key,
    this.color$1,
    this.color$2,
    this.isSelected = false,
    required this.onSelectColor,
  }) : super(key: key);
  final Color? color$1;
  final Color? color$2;
  final bool isSelected;
  final Function((Color?, Color?)?) onSelectColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectColor((color$1, color$2)),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color$1,
          border: Border.all(color: ColorStyles.black3),
          image: color$1 == null
              ? DecorationImage(
                  image: NetworkImage(
                      "https://thumbs.dreamstime.com/b/background-transparency-chess-board-square-grid-line-gray-white-transparent-mesh-transparent-pattern-background-simulation-220272478.jpg"),
                )
              : null,
          gradient: color$2 == null
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [color$1!, color$2!],
                ),
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
