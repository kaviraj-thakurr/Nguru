import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/circular/circular_cubit.dart';
import 'package:nguru/logic/circular/circular_state.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class CircularScreen extends StatefulWidget {
  const CircularScreen({super.key});

  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
 final TextEditingController searchController = TextEditingController();
  List<CircularList> filteredCirculars = [];

 final int currentDate = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    context.read<CircularCubit>().getCurrentCircular(month: currentDate);
    searchController.addListener(_filterCirculars);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCirculars);
    searchController.dispose();
    super.dispose();
  }

  void _filterCirculars() {
    setState(() {
      final query = searchController.text.toLowerCase();
      final circularCubit = context.read<CircularCubit>();
      final currentState = circularCubit.state;
      if (currentState is CircularSuccessState) {
        filteredCirculars = currentState.circularList.where((circular) {
          final subject = circular.subject?.toLowerCase() ?? '';
          return subject.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
        Padding(
          padding: const EdgeInsets.all(padding20),
          child: SafeArea(
            child: Column(
              children: [
                customAppBar(),
                CustomSearchBar(controller: searchController,
                
              
                onTap: () {
                   context.read<CircularCubit>().getCurrentCircular(month: currentDate);
                },),
                screenTitleHeader(MyStrings.circular,
                    onPressed: () => Navigator.pop(context)),
                5.heightBox,
                circularCalendar(),
                Expanded(
                  child: BlocBuilder<CircularCubit, CircularState>(
                    builder: (context, state) {
                      if (state is CircularLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CircularSuccessState) {
                        final circularsToShow = searchController.text.isEmpty
                            ? state.circularList
                            : filteredCirculars;
                        return circularsToShow.isEmpty
                            ? Center(
                                child: Column(
                                children: [
                                  160.heightBox,
                                  SvgPicture.asset(
                                    MyAssets.noDataFound,
                                    height: height150,
                                  ),
                                  5.heightBox,
                                  Text(
                                    MyStrings.circularTitle,
                                    style: FontUtil.customStyle(
                                        fontSize: 14.h,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: APP_FONT,
                                        textColor: MyColors.noDataFoundTitle),
                                  ),
                                  Text(
                                    MyStrings.circularSubTittle,
                                    style: FontUtil.customStyle(
                                        fontSize: 10.h,
                                        fontWeight: FontWeight.w400,
                                        textColor:
                                            MyColors.noDataFoundSubtitle),
                                  )
                                ],
                              ))
                            : PageView.builder(
                                itemCount: (circularsToShow.length / 11).ceil(),
                                itemBuilder: (context, pageIndex) {
                                  final startIndex = pageIndex * 11;
                                  final endIndex =
                                      (startIndex + 11) > circularsToShow.length
                                          ? circularsToShow.length
                                          : (startIndex + 11);
                                  final circulars = circularsToShow.sublist(
                                      startIndex, endIndex);

                                  return ListView.builder(
                                    itemCount: circulars.length,
                                    itemBuilder: (context, index) {
                                      final circular = circulars[index];
                                      return Column(
                                        children: [
                                          cardDesign(
                                            context: context,
                                            circular: circular,
                                          ),
                                          AppGapping.padding10
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                      } else if (state is CircularErrorState) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget cardDesign(
      {required BuildContext context, required CircularList circular}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight*0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius8),
        color: MyColors.searchBackGroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Row(
          children: [
            Image.asset(MyAssets.books),
            12.widthBox,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    circular.subject ?? MyStrings.noSubject,
                    style: FontUtil.circularTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        circular.description ?? MyStrings.noDescription,
                        style: FontUtil.circularSubtitle,
                      ),
                      IconButton(
                        onPressed: () {
                          
                        },
                        icon: SvgPicture.asset(MyAssets.download),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
