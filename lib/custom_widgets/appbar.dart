import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/logic/notification/notification_state.dart';
import 'package:nguru/screens/contact_screen.dart';

import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

import 'package:velocity_x/velocity_x.dart';

Appbar customappbar() {
  return Appbar();
}

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<Appbar> {
 
  String selectedIcon = '';
  @override
  void initState() {
    context.read<NotificationCubit>().notificationCount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            
            children: [
              Text("ANU DRAVID", style: FontUtil.customStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.sessionText),
                    ),
              8.widthBox,
             
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
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen()))
                        .then((value) => setState(() {
                              selectedIcon = 'school';
                            }));
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
                  if (state is NotificationLoadingState) {
                    return const Center(child: SizedBox());
                  } else if (state is NotificationErrorState) {
                    return const Center(child: Text("error"));
                  } else if (state is NotificationSuccessState) {
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
                          child: Center(
                              child: Text(
                            "${state.notificationCount ?? ""}",
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
                  } else {
                    return const Text("qwerty");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
