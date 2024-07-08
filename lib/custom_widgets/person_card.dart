import 'package:flutter/material.dart';
import 'package:nguru/utils/my_colors.dart';

Widget personInfoCard(BuildContext context, String profileImage,
    String personName, String classAndSection, String idNo) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.59,
    height: MediaQuery.of(context).size.height * 0.35,
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
        children: [
          profileImage.isNotEmpty
              ? CircleAvatar(
                  radius: 55.0,
                  backgroundImage: NetworkImage(profileImage),
                )
              : const CircleAvatar(
                  radius: 55.0,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Placeholder image URL
                ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                personName ?? "Name Surname",
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: MyColors.boldTextColor),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                classAndSection ?? "__-_",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: MyColors.fadedTextColor,
                ),
              ),
              Text(
                idNo ?? "123",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: MyColors.fadedTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
