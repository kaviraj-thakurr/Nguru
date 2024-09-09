import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/circular/circular_detail/circular_detail_state.dart';
import 'package:nguru/logic/circular/circular_detail/curcular_detail_cubit.dart';
import 'package:nguru/models/circularDetailsModel.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:velocity_x/velocity_x.dart';

class CircularDetailPage extends StatefulWidget {
  final CircularDetailModel? circularDetailModel;
  final int? circularID;
  final String? circularNo;
  const CircularDetailPage(
      {super.key, this.circularDetailModel, this.circularID, this.circularNo});

  @override
  State<CircularDetailPage> createState() => _CircularDetailPageState();
}

class _CircularDetailPageState extends State<CircularDetailPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CircularDetailsCubit>().getCurrentCircularDetails(
        circularID: widget.circularID, circularNo: widget.circularNo);
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
            padding: const EdgeInsets.all(padding15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dashboardAppBar(),
                10.heightBox,
                CustomSearchBar(controller: searchController),
                10.heightBox,
                screenTitleHeader("Circular Details",
                    onPressed: () => Navigator.pop(context)),
BlocBuilder<CircularDetailsCubit,CircularDetailState>(
  builder: (context,state) {
    if(state is CircularDetailLoadingState){
      return const Center(child: CircularProgressIndicator(),);
    } else if (state  is CircularDetailSuccessState){
      return   Expanded(
        child: ListView.builder(
          itemCount: state.circularDetailList.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                Text("ffio--"),
              ],
            );
          }),
      );
    }else{
      return const SizedBox.shrink();
    }
   
  }
)

              ],
            ),
          )
        ],
      ),
    );
  }
}
