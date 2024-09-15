import 'package:flutter/material.dart';
import 'package:flutter_multi_touch/src/themes/colors.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? labelText;
  final String? labelInput;
  final void Function(String)? onChanged;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final double radius;
  final String? initValue;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool hasKeyboardAction;
  final bool isShowCountText;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color enabledBorderColor;

  const AppInput({
    Key? key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.onChanged,
    this.minLines = 1,
    this.maxLength,
    this.maxLines = 1,
    this.radius = 6,
    this.style,
    this.labelText,
    this.initValue,
    this.focusNode,
    this.onTap,
    this.hintStyle,
    this.labelInput,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.hasKeyboardAction = false,
    Color? focusedBorderColor,
    Color? disabledBorderColor,
    Color? enabledBorderColor,
    this.isShowCountText = true,
  })  : focusedBorderColor = focusedBorderColor ?? ColorStyles.blue7,
        enabledBorderColor = enabledBorderColor ?? ColorStyles.black2,
        disabledBorderColor = disabledBorderColor ?? ColorStyles.black2,
        super(key: key);

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      cursorColor: ColorStyles.black10,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      style: widget.style ?? TextStyle(color: ColorStyles.black10),
      controller: widget.controller,
      onChanged: (text) {
        widget.onChanged?.call(text.trim());
      },
      initialValue: widget.initValue,
      onFieldSubmitted: (String text) {
        widget.onFieldSubmitted?.call(text.trim());
      },
      readOnly: widget.readOnly,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      decoration: InputDecoration(
        counterText: widget.isShowCountText ? null : '',
        errorStyle: TextStyle(color: ColorStyles.red7),
        errorMaxLines: 3,
        isDense: true,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextStyle(color: ColorStyles.black5),
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: ColorStyles.kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: ColorStyles.kPrimaryColor,
          ),
        ),
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
