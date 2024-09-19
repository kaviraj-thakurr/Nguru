import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/settings/change_siblings_cubit.dart';
import 'package:nguru/logic/settings/change_siblings_state.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangeSiblings extends StatefulWidget {
  const ChangeSiblings({super.key});

  @override
  State<ChangeSiblings> createState() => _ChangeSiblingsState();
}

class _ChangeSiblingsState extends State<ChangeSiblings> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // Fetch the siblings list when the widget is initialized
    context.read<SiblingListCubit>().getSiblingsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              MyAssets.bg,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(padding18),
            child: Column(
              children: [
                10.heightBox,
                dashboardAppBar(),
                5.heightBox,
                screenTitleHeader("Change Siblings",
                    onPressed: () => Navigator.pop(context)),
                Expanded(
                  child: BlocBuilder<SiblingListCubit, SiblingListState>(
                    builder: (context, state) {
                      if (state is SiblingListLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SiblingListSuccessState) {
                        return ListView.builder(
                          itemCount:
                              state.changeSiblingsModel.siblingList?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            final sibling =
                                state.changeSiblingsModel.siblingList?[index];
                            return customSettingProfileWidget(
                              context,
                              screenWidth,
                              screenHeight,
                              sibling?.studentName ?? "",
                              sibling?.studentPicture ??
                                  "", // Pass the image URL
                              sibling?.studentId ?? 0,
                            );
                          },
                        );
                      }
                      return Container(); // Handle other states (e.g., error) if needed
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card Design UI
  Widget customSettingProfileWidget(BuildContext context, double screenWidth,
      double screenHeight, String name, String imageUrl, int admissionNumber) {
    return GestureDetector(
      onTap: () async {
        ///onTap of StudentId update

        await SharedPref.saveStudentID(admissionNumber.toInt()).then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NguruDashboardScreen())));
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: screenHeight * 0.12,
        child: Card(
          elevation: 0.1,
          color: MyColors.greyShade_5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: imageUrl.isNotEmpty
                      ? Image.memory(
                          base64Decode(imageUrl),
                          fit: BoxFit.fill,
                        ).image
                      : null, // Display the network image if URL is provided
                  backgroundColor: MyColors.greyShade_4,
                  child: imageUrl.isEmpty
                      ? const Icon(Icons.person,
                          color: Colors.white) // Fallback icon if no image
                      : null,
                ),
                10.widthBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: FontUtil.customStyle(
                          fontSize: 18.h,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.textColors),
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        customTags(
                            "Class & Session", // Replace with actual value if available
                            const Color.fromARGB(255, 204, 231, 255),
                            MyColors.blueShades_1),
                        5.widthBox,
                        customTags(
                            admissionNumber.toString(),
                            const Color.fromARGB(255, 251, 225, 218),
                            MyColors.orangeShades_1),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
