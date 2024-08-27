import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/transport/transport_cubit.dart';
import 'package:nguru/logic/transport/transport_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';


class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        context.read<TransportCubit>().getTransportDetails();

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
              child: Column(children: [
                screenTitleHeader(MyStrings.transport,
                    onPressed: () => Navigator.pop(context)),

                    10.heightBox,
                BlocBuilder<TransportCubit,TransportState>(
                  builder: (context,state) {
                    if(state is TransportLoadingState){
                      return const CircularProgressIndicator();
                    }else if (state is TransportSuccessState){
                     return transportCard(context:context,
                     profileImage:MyAssets.placeholderDriverImage,
                    
                     driverName: state.transportDetails.driverName,
                     driverNo: state.transportDetails.contactNo,
                     busStop: state.transportDetails.pickupLocation,
                     dropOff: state.transportDetails.dropLocation
                    

                   
                     );
                    }
                    else{
                      return const SizedBox();
                    }
                   
                  }
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}


  Widget transportCard({required BuildContext context,String?profileImage,String ? driverName , String ? driverNo , String ? busStop, String ? dropOff}) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.maxFinite,
      height: screenHeight * 0.18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.searchBackGroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(padding5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      const CircleAvatar(
                      backgroundImage:NetworkImage(MyStrings.placeholder),
                      maxRadius: 25,
                     
                    ),
                    10.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        driverName??MyStrings.dash,
                          style: FontUtil.customStyle(
                              fontSize: 16.h,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.addButtonColor),
                        ),
                         Text(
                     driverNo??MyStrings.dash,
                      style: FontUtil.customStyle(
                          fontSize: 13.h,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.circular),
                    ),
                      ],
                    ),
                    
    
                  ],
                ),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(padding3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        MyStrings.busStop,
                        style: FontUtil.customStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.busStop),
                      ),
                      Text(
                       busStop??MyStrings.dash,
                       textAlign: TextAlign.right,
                        style: FontUtil.customStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.busStop),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(padding3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        MyStrings.dropOff,
                        style: FontUtil.customStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.busStop),
                      ),
                      Text(
                        dropOff??MyStrings.dash,
                         textAlign: TextAlign.right,
                        style: FontUtil.customStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.busStop),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

