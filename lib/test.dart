// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SimpleCustomRadioButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//         decoration: BoxDecoration(
        
//           borderRadius: BorderRadius.circular(8),
          
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white, // Inner circle color
//                 border: Border.all(color: Colors.blue),
//               ),
//               child: Center(
//                 child: Container(
//                   width: 12,
//                   height: 12,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.blue, // Inner dot color
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 16),
//             Text(
//               'Option 1',
//               style: TextStyle(
//                 color: Colors.white, // Text color
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }