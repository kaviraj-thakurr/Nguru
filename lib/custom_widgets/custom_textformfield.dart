import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    super.key,
    required FocusNode schoolUrlFocusNode,
    required this.schoolurlController,
  }) : _schoolUrlFocusNode = schoolUrlFocusNode;

  final FocusNode _schoolUrlFocusNode;
  final TextEditingController schoolurlController;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget._schoolUrlFocusNode,
      controller: widget.schoolurlController,
      decoration: InputDecoration(
        //   hintText: "kaviraj",hintStyle: TextStyle(fontStyle: FontStyle.italic),
        suffixIcon: IconButton(
            onPressed: () {
              widget._schoolUrlFocusNode.requestFocus();
            },
            icon: SvgPicture.asset(MyAssets.edit)),
        label: const Text(
          MyStrings.schoolurl,
          style: TextStyle(
              // fontStyle: FontStyle.italic,
              fontSize: 15,
              color: Colors.grey,
              fontFamily: "Effra_Trial"),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(9.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.borderColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey, width: 1.0),
          borderRadius:
              BorderRadius.all(Radius.circular(9.0)),
        ),
      ),
      style: FontUtil.signInFieldText,
      validator: (url) {
        if (url == null || url.isEmpty) {
          return MyStrings.enterschoolurl;
        }
        return null;
      },
    );
  }
}