import 'package:flutter/material.dart';
import 'package:flutter_multi_touch/src/widgets/app_input.widget.dart';
import 'package:flutter_multi_touch/src/widgets/title_setting_section.widget.dart';

class CanvasTextFieldSetting extends StatefulWidget {
  const CanvasTextFieldSetting({super.key});

  @override
  State<CanvasTextFieldSetting> createState() => _CanvasTextFieldSettingState();
}

class _CanvasTextFieldSettingState extends State<CanvasTextFieldSetting> {
  double _fontSize = 20;
  double _fontSpacing = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSection(title: "Edit text"),
        AppInput(),
        TitleSection(title: "Font Size"),
        Slider(
          onChanged: (_) {
            setState(() {
              _fontSize = _;
            });
          },
          value: _fontSize,
          min: 1,
          max: 100,
          divisions: 100,
        ),
        TitleSection(title: "Font Spacing"),
        Slider(
          onChanged: (_) {
            setState(() {
              _fontSpacing = _;
            });
          },
          value: _fontSpacing,
          min: -10,
          max: 100,
          divisions: 110,
        ),
      ],
    );
  }
}
