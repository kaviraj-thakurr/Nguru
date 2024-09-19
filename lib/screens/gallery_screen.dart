import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cr_file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/gallery_cubit/gallery_cubit.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/logic/gallery_item_list/gallery_item_list_cubit.dart';
import 'package:nguru/logic/gallery_item_list/gallery_item_list_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/custom_download_file.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:nguru/utils/story.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final TextEditingController _searchController = TextEditingController();
//  late final StoryController _storyController = StoryController();
  int currentIndex = 0; // To track the current gallery index
    DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();


 // downloading file

  Future<void> getSessionDates() async {
    startDate = DateFormat("dd-MMM-yyyy")
        .parse(await SharedPref.getStartDateOfSession() ?? "");
    endDate = DateFormat("dd-MMM-yyyy")
        .parse(await SharedPref.getEndDateOfSession() ?? "");
    log(" init call from dashboard:  $startDate $endDate");
  }






  @override
  void initState() {
    getSessionDates();
    super.initState();
    context.read<GalleryItemListCubit>().getGalleryItemList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // floatingActionButton: GestureDetector(
      //     onTap: () => Navigator.pop(context),
      //     child: SvgPicture.asset(MyAssets.storyDownload)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: [
        Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
        Padding(
          padding: const EdgeInsets.all(padding18),
          child: Column(
            children: [
              10.heightBox,
                  dashboardAppBar(),
                  10.heightBox,
                  CustomSearchBar(controller: _searchController),
                  10.heightBox,
                  screenTitleHeader("Photo Gallery",
                      onPressed: () => Navigator.pop(context)),
                      20.heightBox,
              Flexible(
                child: BlocBuilder<GalleryItemListCubit, GalleryItemListState>(
                  builder: (context, state) {
                    if (state is GalleryItemListLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GalleryItemListSuccessState) {
                      bool isNavigating = false; 
                      return 
                      state.galleryItemList.galleryList!.isEmpty ?
                           Center(
                              child: Column(
                              children: [
                                160.heightBox,
                                SvgPicture.asset(
                                  MyAssets.noDataFound,
                                  height: height150,
                                ),
                                5.heightBox,
                                Text(
                                  MyStrings.noGalleryItemsFound,
                                  style: FontUtil.customStyle(
                                      fontSize: 14.h,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: APP_FONT,
                                      textColor: MyColors.noDataFoundTitle),
                                ),
                              ],
                            ))
                            :
                      GridView.builder(
                          itemCount:
                              state.galleryItemList.galleryList?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 160,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            final galleryItem =
                                state.galleryItemList.galleryList![index];
                            final dashPictureGalleryId = state.galleryItemList
                                .galleryList?[index].dashPichtureGalleryId;
                            return GestureDetector(
                              onTap: () {
                                if (isNavigating) return;
                                isNavigating = true;
                                 context
                                  .read<GalleryPhotosCubit>()
                                  .getGalleryPhotos(dashPictureGalleryId)
                                  .then(
                                    (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => showStories(
                                                screenHeight,
                                                screenWidth,
                                                dashPictureGalleryId ?? 0))).then((value) => isNavigating = false),
                                                
                                  );
                              },
                              child: customPhotoWidget(
                                  screenHeight,
                                  screenWidth,
                                  // firstPhoto,
                                  galleryItem.subject ?? ""),
                            );
                          });
                    } else if (state is GalleryItemListErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(
                          child: Text(MyStrings.undefinedState));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget customPhotoWidget(
      double screenHeight,
      double screenWidth,
      //  String? photo,
      String description) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyColors.grey,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: MyColors.borderColor,
              width: 1.0,
            ),
          ),
          height: screenHeight * 0.13,
          width: screenWidth * 0.3,
          // child: photo != null
          //     ? Image.memory(
          //         base64Decode(photo),
          //         fit: BoxFit.cover,
          //       )
          //     : Container(),
          child: const Icon(Icons.photo),
        ),
        8.heightBox,
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            description,
            style: FontUtil.customStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textColor: MyColors.fadedTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget showStories(
      double screenHeight,
      double screenWidth,
      int dashPictureGalleryId) {
    return BlocConsumer<GalleryPhotosCubit, GalleryPhotosState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GalleryPhotosLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is GalleryPhotosSuccessState) {
            int storyIndex=0;
            List<String> photos = [];
          //  List<StoryItem> storyItems = [];
            List<Story> storyItemss = [];
            Story item=Story(base64Image: "",startDate,endDate);
            

            for (int i = 0; i < state.galleryPhotos.photoList!.length; i++) {
              photos.add(state.galleryPhotos.photoList![i].photo ?? "");
              item=Story(startDate,endDate,base64Image: state.galleryPhotos.photoList![i].photo ?? "",duration:const Duration(seconds: 3),);

              // storyItems.add(customStoryWidget(
              //   screenHeight,
              //   screenWidth,
              //   state.galleryPhotos.photoList![i].photo ?? "",
              // )
              storyItemss.add(item);
            }

            log("Particular story count: ${photos.length}");

            return Scaffold(
              floatingActionButton: GestureDetector(
                  child: SvgPicture.asset(MyAssets.floatingActionDownloadButton),
                  
                  onTap: () => {
                    onSaveWithDialogPressed(state.galleryPhotos.photoList![storyIndex].photo ?? ""),

                  }),
                  
              floatingActionButtonLocation:  FloatingActionButtonLocation.endFloat,
              body:  
              // StoryView(
              //   indicatorForegroundColor: MyColors.appColorBlue,
              //   storyItems: storyItems,
              //   controller: _storyController,
              //   repeat: false,
              //   onComplete: () {
              //     setState(() {
              //       storyIndex=storyIndex+1;
              //       log("$storyIndex");
              //     });
                 
              //   },
              //   onVerticalSwipeComplete: (direction) {
              //     if (direction == Direction.down) {
              //       Navigator.pop(context);
              //     }
              //   },
              // ),

              StoryView(
                isAssignmentWidget: false,
          isGalleryWidget: true,
          isCircularWidget: false,
          isDisciplineWidget: false,
          stories: storyItemss,
          subjectList: [],
          circularList: [],
          disciplineList: [],
          startDate: startDate,
          endDate: endDate,
        ),

            );
          } else if (state is GalleryPhotosErrorState) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return const Scaffold(
                body:  Center(child: Text(MyStrings.undefinedState)));
          }
        });
  }

  // StoryItem customStoryWidget(
  //     double screenHeight, double screenWidth, String photo) {
  //   return StoryItem(
  //     SizedBox(
  //       height: screenHeight * 1,
  //       width: double.infinity,
  //       child: Image.memory(
  //         base64Decode(photo),
  //         fit: BoxFit.scaleDown,
  //       ),
  //     ),
  //     duration: const Duration(seconds: 3),
  //   );
  // }
}
