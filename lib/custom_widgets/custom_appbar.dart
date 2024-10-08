import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_state.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/logic/notification/notification_state.dart';
import 'package:nguru/screens/Communication/communication.dart';
import 'package:nguru/screens/notification_screen.dart';
import 'package:nguru/screens/transport/transport_screen.dart';

import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

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
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                if (state is DashboardLoadingState) {
                  return Text(
                    "_ _",
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.sessionText),
                  );
                } else if (state is DashboardSuccessState) {
                  return Text(
                    state.studentName ?? "_",
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.sessionText),
                  );
                } else if (state is DashboardErrorState) {
                  return Text(
                    "_ _",
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.sessionText),
                  );
                } else {
                  return Text(
                    "_ _",
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.sessionText),
                  );
                }
              }),
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
                    // Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const ContactScreen()))
                    //  .then((value) =>
                    setState(() {
                      selectedIcon = 'school';
                    });
                    //);
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
                    NavigationService.navigateTo(
                        const TransportScreen(), context);
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
                    NavigationService.navigateTo(
                        const CommunicationScreen(), context);
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
                            NavigationService.navigateTo(
                                const NotificationScreen(), context);
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
