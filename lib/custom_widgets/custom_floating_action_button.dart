// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nguru/utils/app_assets.dart';
// import 'package:nguru/utils/my_assets.dart';


// Widget customFloatingActionButton(BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       log("tap");
//     },
//     child: Container(
//       height: MediaQuery.of(context).size.height * 0.1,
//       width: MediaQuery.of(context).size.width * 0.2,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         //   gradient: MyColors.buttonColors,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 0.1,
//             blurRadius: 7,
//             offset: const Offset(0, 1), // changes position of shadow
//           ),
//         ],
//       ),
//       child: CircleAvatar(
//         radius: 70,
//         backgroundColor: Colors.transparent,
//         child: SvgPicture.asset(
//           MyAssets.floatingActionIcon,
//           width: 100,
//           height: 100,
//         ),
//       ),
//     ),
//   );
// }
