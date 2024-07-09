import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget personInfoCard(
  BuildContext context,
  String profileImage,
  String personName,
  String classAndSection,
  String idNo,
  Function(String) onNameChange,
) {
  List<String> names = ['Anshul Goswami', 'Kaviraj Thakur'];
  ;

  // Ensure the personName is a valid value
  if (!names.contains(personName)) {
    personName = names.first;
  }

  return Container(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.width * 0.5,
      maxWidth: MediaQuery.of(context).size.width * 0.53,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.borderColor,
        width: 1.0,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          profileImage.isNotEmpty
              ? CircleAvatar(
                  radius: 45.0,
                  backgroundImage: NetworkImage(profileImage),
                )
              : const CircleAvatar(
                  radius: 55.0,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Placeholder image URL
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                underline: const SizedBox.shrink(),
                alignment: AlignmentDirectional.center,
                value: personName,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                iconSize: 24,
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
                onChanged: (String? newValue) {
                  onNameChange(newValue ?? "");
                },
                items: names.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(classAndSection,
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        textColor: MyColors.fadedTextColor)),
                Text(idNo,
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        textColor: MyColors.textcolors)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
