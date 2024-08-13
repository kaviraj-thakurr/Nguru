import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool read;
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
  final InputDecoration? decoration;
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
    this.read = false,
    this.validator,
    this.suffixIconAsset,
    this.suffixIcon,
    this.autoValidateMode,
    this.obscureText,
    this.decoration,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      suffixIcon: widget.suffixIcon ??
          (widget.suffixIconAsset != null
              ? IconButton(
                  onPressed: () {
                    widget.focusNode?.requestFocus();
                  },
                  icon: SvgPicture.asset(widget.suffixIconAsset!),
                )
              : null),
      labelText: widget.labelText,
      labelStyle: widget.labelStyle ??
          const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontFamily: APP_FONT,
          ),
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      border: widget.border ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
      enabledBorder: widget.enabledBorder ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.borderColor,
            ),
          ),
      focusedBorder: widget.focusedBorder ??
          const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
    );

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      focusNode: widget.focusNode,
      readOnly: widget.read,
      controller: widget.controller,
      autovalidateMode: widget.autoValidateMode,
      obscureText: widget.obscureText ?? false,
      decoration: widget.decoration ?? defaultDecoration,
      style: widget.style ?? FontUtil.signInFieldText,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
