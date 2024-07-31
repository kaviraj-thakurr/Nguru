
import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget personInfoCard(
    BuildContext context,
    String profileImage,
    String personName,
    String classAndSection,
    String idNo,
   // Function(String) onNameChange,
    ) {
 

  // Ensure the personName is a valid value
 

  return Container(
    padding: const EdgeInsets.all(16.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.2,
      maxWidth: MediaQuery.of(context).size.width * 0.52,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.borderColor,
        width: 1.0,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        profileImage.isNotEmpty
            ? Flexible(
          flex: 2,
          child: CircleAvatar(
            radius: 45.0,
            backgroundImage: NetworkImage(profileImage),
          ),
        )
            :const Flexible(
          child:  CircleAvatar(
            radius: 45.0,
            backgroundImage:
            NetworkImage('https://via.placeholder.com/150'),
          ),
        ),

        // for drop down value change (will make it bottom drop down)
        // DropdownButton<String>(
        //   underline: const SizedBox.shrink(),
        //   alignment: AlignmentDirectional.center,
        //   value: personName,
        //   icon: const Icon(Icons.keyboard_arrow_down_outlined),
        //   iconSize: 24,
        //   style: FontUtil.customStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.w500,
        //       textColor: MyColors.boldTextColor),
        //   onChanged: (String? newValue) {
        //     onNameChange(newValue!);
        //   },
        //   items: names.map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                personName,
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
            ),
            GestureDetector(
                child: const Icon(Icons.keyboard_arrow_down_outlined)),
          ],
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(classAndSection,
                  style: FontUtil.customStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.textColors)),
              const Spacer(),
              Text(idNo,
                  style: FontUtil.customStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.textColors)),
            ],
          ),
        ),
      ],
    ),
  );
}