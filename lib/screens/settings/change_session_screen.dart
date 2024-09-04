import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/settings/change_session/change_session_cubit.dart';
import 'package:nguru/logic/settings/change_session/change_session_state.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangeSessionScreen extends StatefulWidget {
  const ChangeSessionScreen({super.key});

  @override
  State<ChangeSessionScreen> createState() => _ChangeSessionScreenState();
}

class _ChangeSessionScreenState extends State<ChangeSessionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<ChangeSessionCubit>().changeSession();
    getDates();
    super.initState();
  }

  Future<void> getDates() async {
    log("gettingg the session date: ${DateFormat("dd-MMM-yyyy").parse(await SharedPref.getStartDateOfSession() ?? "")} ${DateFormat("dd-MMM-yyyy").parse(await SharedPref.getEndDateOfSession() ?? "")}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(MyAssets.background_2),
      Column(children: [
        10.heightBox,
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: dashboardAppBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: CustomSearchBar(controller: _searchController),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: screenTitleHeader(MyStrings.changeSession,
              onPressed: () => Navigator.pop(context)),
        ),
        Expanded(
            child: BlocConsumer<ChangeSessionCubit, ChangeSessionState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ChangeSessionLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ChangeSessionSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.changeSessionList.length,
                          itemBuilder: (context, index) {
                            var items = state.changeSessionList[index];
                            List<String> datTime = state
                                .changeSessionList[index].value!
                                .split(']-[');
                            log("datTime: ${datTime[0]} , ${datTime[1]}");
                            // Convert each list in the nested list to a string
                            String startDate =
                                datTime[0].substring(1, datTime[0].length);
                            String endDate =
                                datTime[1].substring(0, datTime[1].length - 1);
                            log("$startDate $endDate");

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async => await SharedPref
                                          .saveSessionID(items.key ?? 0)
                                      .then((value) async => {
                                            await SharedPref
                                                .saveStartDateOfSession(
                                                    startDate),
                                            await SharedPref
                                                .saveEndDateOfSession(endDate),
                                                await SharedPref.saveSessionSeleted(isSessionSelected: true),

                                            //log("gettingg the session date: ${ DateFormat("dd-MMM-yyyy").parse(await SharedPref.getStartDateOfSession() ?? "") } ${  DateFormat("dd-MMM-yyyy").parse(await SharedPref.getEndDateOfSession() ?? "")  }"),
                                          })
                                      .then((value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NguruDashboardScreen()))),
                                  child: ListTile(
                                    title: Text(
                                      "${items.value}",
                                      style: FontUtil.customStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          textColor: MyColors.boldTextColor),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                15.heightBox,
                              ],
                            );
                          }),
                    );
                  } else if (state is ChangeSessionErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: FontUtil.customStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.boldTextColor),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        MyStrings.undefinedState,
                        style: FontUtil.customStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.boldTextColor),
                      ),
                    );
                  }
                })),
      ])
    ]));
  }
}
