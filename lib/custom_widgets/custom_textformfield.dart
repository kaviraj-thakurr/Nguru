import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final String? suffixIconAsset;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final bool? obscureText;
  final InputDecoration? decoration; // Add this line
  final void Function(String)? onChanged;

  const CustomTextFormField({
    this.controller,
    this.inputFormatters,
    this.focusNode,
    this.labelText,
    this.labelStyle,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.style,
    this.validator,
    this.suffixIconAsset,
    this.suffixIcon,
    this.autoValidateMode,
    this.obscureText,
    this.decoration, // Add this line
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      suffixIcon: suffixIcon ??
          (suffixIconAsset != null
              ? IconButton(
                  onPressed: () {
                    focusNode?.requestFocus();
                  },
                  icon: SvgPicture.asset(suffixIconAsset!),
                )
              : null),
      labelText: labelText,
      labelStyle: labelStyle ??
          const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontFamily: APP_FONT,
          ),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      border: border ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
      enabledBorder: enabledBorder ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.borderColor,
            ),
          ),
      focusedBorder: focusedBorder ??
          const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
    );

    return TextFormField(
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      controller: controller,
      autovalidateMode: autoValidateMode,
      obscureText: obscureText ?? false,
      decoration: decoration ?? defaultDecoration, // Add this line
      style: style ?? FontUtil.signInFieldText,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
