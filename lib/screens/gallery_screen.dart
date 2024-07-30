import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/gallery_cubit/gallery_cubit.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/models/gallery/gallery_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

import 'package:story_view/story_view.dart';

import 'package:velocity_x/velocity_x.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final StoryController _storyController = StoryController();

  @override
  void initState() {
    super.initState();
    context.read<GalleryPhotosCubit>().getGalleryPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton:
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: SvgPicture.asset("assets/icons/floating_action_button.svg")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      body: Stack(
        children: [
          Positioned.fill(
                  child: Image.asset(
                MyAssets.bg,
                fit: BoxFit.fill,
              )),
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              dashboardAppBar(),
        
              CustomSearchBar(controller: _searchController),
              screenTitleHeader("Photo Gallery",onPressed: ()=>Navigator.pop(context)),
              Flexible(
                child: BlocBuilder<GalleryPhotosCubit, GalleryPhotosState>(
                  builder: (context, state) {
                    if (state is GalleryPhotosLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GalleryPhotosSuccessState) {
                      return GridView.builder(
                        itemCount:
                            state.galleryPhotos.photogalleryList?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final galleryItem =
                              state.galleryPhotos.photogalleryList![index];
                          final firstPhoto = galleryItem.photoList!.isNotEmpty
                              ? galleryItem.photoList![0].photo
                              : null;
        
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => showStories(
                                          screenHeight,
                                          screenWidth,
                                          galleryItem))),
                              child: customPhotoWidget(screenHeight, screenWidth,
                                  firstPhoto, galleryItem.description ?? ""));
                        },
                      );
                    } else if (state is GalleryPhotosErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text("Unknown error occurred"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }

  Widget customPhotoWidget(double screenHeight, double screenWidth,
      String? photo, String description) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: MyColors.borderColor,
              width: 1.0,
            ),
          ),
          height: screenHeight * 0.1,
          width: screenWidth * 0.3,
          child: photo != null
              ? Image.memory(
                  base64Decode(photo),
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
        8.heightBox,
        Text(
          description,
          style: FontUtil.customStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textColor: MyColors.fadedTextColor,
          ),
        )
      ],
    );
  }

  Widget showStories(
      double screenHeight, double screenWidth, PhotogalleryList galleryItem) {
    List<String> photos = [];
    List<StoryItem> stoyItems = [];

    for (int i = 0; i < galleryItem.photoList!.length; i++) {
      photos.add(galleryItem.photoList![i].photo ?? "");
      stoyItems.add(customStoryWidget(
          screenHeight, screenWidth, galleryItem.photoList![i].photo ?? ""));
    }
    log("perticular story count: ${photos.length}");
    return Scaffold(
       floatingActionButton:
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: SvgPicture.asset("assets/icons/floating_action_down_button.svg")),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: StoryView(
          indicatorForegroundColor: MyColors.appColorBlue,
          storyItems: stoyItems,
          controller: _storyController,
          repeat: true,
          //  onStoryShow: (s) {},
          onComplete: () {},
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          }),
    );
  }

  StoryItem customStoryWidget(
      double screenHeight, double screenWidth, String photo) {
    return StoryItem(
        SizedBox(
          height: screenHeight * 1,
          width: double.infinity,
          child: Image.memory(
            base64Decode(photo ?? ""),
            fit: BoxFit.scaleDown,
          ),
        ),
        duration: const Duration(seconds: 3));
  }
}
