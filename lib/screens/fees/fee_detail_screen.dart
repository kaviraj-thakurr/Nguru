import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/fee/fee_list_cubit.dart';
import 'package:nguru/logic/fee/fee_list_state.dart';
import 'package:nguru/screens/fees/fee_main_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:slider_button/slider_button.dart';
import 'package:velocity_x/velocity_x.dart';

class FeeDetailScreen extends StatefulWidget {
  const FeeDetailScreen({super.key});

  @override
  State<FeeDetailScreen> createState() => _FeeDetailScreenState();
}

class _FeeDetailScreenState extends State<FeeDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  int totalFee = 0;
  int paidFee = 0;

  @override
  void initState() {
    super.initState();
    context.read<FeeListCubit>().getFeeList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          BlocConsumer<FeeListCubit, FeeListState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FeeListLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FeeListSuccessState) {
                  return Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1,
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomAppBar(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CustomSearchBar(controller: _searchController),
                          ),
                          screenTitleHeader(MyStrings.fee,
                              onPressed: () => Navigator.pop),
                          15.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customFeeDetailHeader(context,
                                  screenHeight * 0.126, screenWidth * 0.28),
                              customFeeDetailHeader(context,
                                  screenHeight * 0.139, screenWidth * 0.34,
                                  isCenter: true),
                              customFeeDetailHeader(context,
                                  screenHeight * 0.126, screenWidth * 0.28),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.53,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: state.feeListModel.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      customFeeHistoryCard(context,
                                          totalFeeModel:
                                              state.feeListModel[index]),
                                      15.heightBox,
                                    ],
                                  );
                                }),
                          ),
                          10.heightBox,
                          SliderButton(
                              width: double.infinity,
                              backgroundColor:
                                  MyColors.fadedTextColor.withOpacity(0.1),
                              buttonColor: Colors.transparent,
                              action: () async {
                                ///Do something here OnSlide
                                return true;
                              },
                              label: const Center(
                                child: Text(
                                  MyStrings.proceedToPay,
                                  style: TextStyle(
                                      color: Color(0xff4a4a4a),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                              icon: SvgPicture.asset(MyAssets.pay)),
                        ],
                      ),
                    ),
                  );
                } else if (state is FeeListErrorState) {
                  return Text(
                    MyStrings.undefinedState,
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.boldTextColor),
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
              }),
        ],
      ),
    );
  }
}

Widget customFeeDetailHeader(
    BuildContext context, double screenHeight, double screenWidth,
    {bool isCenter = false}) {
  return Container(
    width: screenWidth,
    height: screenHeight,
    decoration: BoxDecoration(
        color: MyColors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.circle,
                  color: MyColors.greenShade_2,
                  size: 12,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "23k",
                  style: FontUtil.customStyle(
                      fontSize: isCenter ? 48 : 36,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.totalFee,
                  style: FontUtil.customStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor.withOpacity(0.6)),
                ),
                SvgPicture.asset(
                  MyAssets.next,
                  height: 18,
                  width: 18,
                )
              ],
            )
          ]),
    ),
  );
}
