import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/communication/communication_cubit.dart';
import 'package:nguru/logic/communication/communication_state.dart';
import 'package:nguru/screens/Communication/chat_screen.dart';
import 'package:nguru/screens/transport/transport_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
   final TextEditingController searchController = TextEditingController();
   @override
  void initState() {
    context.read<CommunicationCubit>().getCommunicationDetails();
   
    super.initState();
    
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
         Padding(padding: 
      const EdgeInsets.all(padding20),
      child: SafeArea(child: Column(
        children: [
          customAppBar(),
           CustomSearchBar(controller: searchController),
                screenTitleHeader(MyStrings.chat,
                    onPressed: () => Navigator.pop(context)),

                    Expanded(
                      child: BlocBuilder<CommunicationCubit,CommunicationState>(
                        builder: (context,state) {
                          if(state is CommunicationLoadingState){
                            const CircularProgressIndicator();
                          }
                          else if (state is CommunicationSuccessState){
                            return ListView.builder(
                            itemCount: state.communicationModel.listCommunicationHeaderDetail?.length,
                            itemBuilder: (context, index){
                          
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                    NavigationService.navigateTo(
                        const ChatScreen(), context);
                                    },
                                    child: cardDesign(context: context,
                                    image: "image",
                                    teacherName: state.communicationModel.listCommunicationHeaderDetail?[index].subjectName,
                                    description: state.communicationModel.listCommunicationHeaderDetail?[index].content),
                                  ),
                                  AppGapping.padding10
                                ],
                              );
                          
                          });
                          }
                          return const SizedBox();
                         
                        }
                      ),
                    )

        ],
      )),)

        ],
      ),
    );
  }

 Widget cardDesign({
  required BuildContext context, 
  String? image, 
  String? teacherName, 
  String? description
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;


  ImageProvider imageProvider;
  if (image != null && image.isNotEmpty) {
    imageProvider = NetworkImage(image);
  } else {
    imageProvider = const AssetImage(MyAssets.school);
  }

  return Container(
    height: screenHeight * 0.11,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius8),
      color: MyColors.searchBackGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(padding8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: imageProvider,
          ),
          12.widthBox,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  teacherName ?? MyStrings.noSubject,
                  style: FontUtil.circularTitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      description ?? MyStrings.noDescription,
                      style: FontUtil.circularSubtitle,
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