import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/infirmary_all/infirmary/infirmary_cubit.dart';
import 'package:nguru/logic/infirmary_all/infirmary/infirmary_state.dart';
import 'package:nguru/screens/setting_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class InfirmaryScreen extends StatefulWidget {
  const InfirmaryScreen({super.key});

  @override
  State<InfirmaryScreen> createState() => _InfirmaryScreenState();
}

class _InfirmaryScreenState extends State<InfirmaryScreen> {
  final TextEditingController _searchController = TextEditingController();
    List<String> months = [
    "Illness",
    "Vaccination",
    "Body Details",
  ];
    int seletedIndex = 0;

  DateTime? _selectedDay;
    DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    context.read<InfirmaryCubit>().getInfirmary();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                20.heightBox,
                dashboardAppBar(),
                CustomSearchBar(controller: _searchController),
                20.heightBox,
                screenTitleHeader("Infirmary",
                    onPressed: () => Navigator.pop(context)),
                20.heightBox,
                customSettingProfileWidget(context, screenWidth, screenHeight,
                    "name", "10th A", "1237/AA/2023B",
                    bloodGroup: "O+", gender: "Male"),
                20.heightBox,
                // Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         _buildCategorySelector(),
                //       ],
                //     ),
                //     20.heightBox,
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Daily Entries ",
                          style: FontUtil.customStyle(
                              fontSize: 17.h,
                              fontWeight: FontWeight.w700,
                              textColor: MyColors.boldTextColor),
                        ),
                        TextSpan(
                          text: "(16)",
                          style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              textColor:
                                  MyColors.monthNameColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                15.heightBox,
                Expanded(
                  child: SizedBox(
                   child: BlocConsumer<InfirmaryCubit,InfirmaryState>(
                    listener: (context, state) {
                      
                    },
                     builder: (context,state) {

                      if(state is InfirmaryLoadingState){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                     else if(state is InfirmarySuccessState){
                        return ListView.builder(
                        itemCount: state.infirmary.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                        return Column(
                          children: [
                            customInfirmaryItems(context,
                            illnessHeading: state.infirmary[index].illnessHeading??"",
                            illnessDetails: state.infirmary[index].illnessDetails??"",
                            medicine: state.infirmary[index].medicine??"",
                            dosage: state.infirmary[index].amountofDose??"",
                            remarks: state.infirmary[index].remarks??"",
                            date: state.infirmary[index].illnessDate??""
                             

                            ),
                            15.heightBox
                          ],
                        );
                       });
                      }
                      else if(state is InfirmaryErrorState){
                        return  Center(child: Text("${state.message}",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
                      }
                      else {
                      return  Center(child:  Text("${{MyStrings.undefinedState}}",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
                      }
                       
                     }
                   ),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }


    Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    months.indexOf(month) + 1,
                  );
                });
                seletedIndex = months.indexOf(month);
                log("selected: ${months.indexOf(month)}");
              },
              child: isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return MyColors.buttonColors.createShader(bounds);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white, // This color is not visible
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          month,
                          style: FontUtil.customStyle(
                            fontSize: 10,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                            textColor: MyColors.monthNameColor,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey, // This color is not visible
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        month,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          textColor: MyColors.monthNameColor,
                        ),
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


Widget customInfirmaryItems(BuildContext context,{String?illnessHeading, String?illnessDetails,String?medicine,String ? dosage , String? remarks,String?date}){
  return Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.235,
                  decoration: BoxDecoration(
                    color: MyColors.greyShade_6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       illnessHeading?? "Dehydration",
                        style: FontUtil.customStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            textColor: MyColors.boldTextColor),
                      ),
                      10.heightBox,
                      Text(
                        illnessDetails??"Lorem ipsum dolor sit amet consectetur. Eleifend eu cursus sodales integer lacus. Tellus sagittis ullamcorper.n",
                        style: FontUtil.customStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.fadedTextColor),
                        maxLines: 2,
                      ),
                      10.heightBox,
                      RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Medicine: ",
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      textColor: MyColors.boldTextColor),
                                ),
                                TextSpan(
                                  text: medicine??"Oral rehydration solutions (ORS)",
                                  //    overflow: TextOverflow.ellipsis,
                                  //    maxLines: 3,
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: MyColors.fadedTextColor
                                          .withOpacity(0.8)),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            // style: FontUtil.circularsubttile,
                          ),
                      10.heightBox,
                      RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Dosage: ",
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      textColor: MyColors.boldTextColor),
                                ),
                                TextSpan(
                                  text: dosage??"1 glass of ORS",
                                  //    overflow: TextOverflow.ellipsis,
                                  //    maxLines: 3,
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: MyColors.fadedTextColor
                                          .withOpacity(0.8)),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            // style: FontUtil.circularsubttile,
                          ),
                      10.heightBox,
                      RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Remark: ",
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      textColor: MyColors.boldTextColor),
                                ),
                                TextSpan(
                                  text: remarks??"Lorem ipsum dolor sit amet consectetur.",
                                  //    overflow: TextOverflow.ellipsis,
                                  //    maxLines: 3,
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: MyColors.fadedTextColor
                                          .withOpacity(0.8)),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            // style: FontUtil.circularsubttile,
                          ),
                          10.heightBox,
                          Text(
                        date??"Monday, July 14, 2023",
                        style: FontUtil.customStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.fadedTextColor),
                        maxLines: 2,
                      ),
            
                    ],
                  ),
                );




}
