import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChange;

  const CustomSearchBar(
      {super.key,
      required this.controller,
      this.hintText = "",
      this.readOnly = false,
      this.onTap,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 50),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: MyColors.searchbackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              onTap: onTap,
              onChanged: onChange,
              readOnly: readOnly,
              controller: controller,
              style:const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: Icon(CupertinoIcons.search,color: MyColors.textcolors),
                hintText: MyStrings.search,
                hintStyle: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w400, textColor: MyColors.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}