import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/logic/notification/notification_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:velocity_x/velocity_x.dart';

CustomAppBar dashboardAppBar() {
  return CustomAppBar();
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedValue = 'Session 2024-25';
  List<String> dropdownItems = [
    'Session 2023-24',
    'Session 2024-25',
    'Session 2025-26'
  ];

  // Variable to keep track of the selected icon
  String selectedIcon = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: selectedValue,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    MyAssets.drop_down_arrow,
                    color: MyColors.addButtonColor,
                  ),
                ),
                underline: const SizedBox.shrink(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    MyAssets.school,
                    color: selectedIcon == 'school' ? MyColors.appColor1 : null,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIcon = 'school';
                    });
                  },
                ),
              ),
              12.widthBox,
              SizedBox(
                height: 25,
                width: 25,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    MyAssets.travel,
                    color: selectedIcon == 'travel' ? MyColors.appColor1 : null,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIcon = 'travel';
                    });
                  },
                ),
              ),
              12.widthBox,
              SizedBox(
                height: 25,
                width: 25,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    MyAssets.message,
                    color:
                        selectedIcon == 'message' ? MyColors.appColor1 : null,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIcon = 'message';
                    });
                  },
                ),
              ),
              12.widthBox,
              BlocConsumer<NotificationCubit, NotificationState>(
                  listener: (context, state) {
          if (state is NotificationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if(state is NotificationLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is NotificationSuccessState) {
            return Stack(children: [
                  Positioned(
                    bottom: 15,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 124, 232, 127)),
                      child: const Center(
                          child: Text(
                        "1",
                        style: TextStyle(fontSize: 10),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                    width: 25,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        MyAssets.notifications,
                        color: selectedIcon == 'notifications'
                            ? MyColors.appColor1
                            : null,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIcon = 'notifications';
                        });
                      },
                    ),
                  ),
                ]);
            
          } else{
                  const Text("data");
          }
          return const SizedBox();
        } ,

                
              ),
            ],
          ),
        ],
      ),
    );
  }
}
