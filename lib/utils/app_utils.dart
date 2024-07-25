  import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';

class AppUtils{
    static Widget noCircular({double size = 180, String text = "No Circular Today ! "}) {
    return Column(
      children: [
        SvgPicture.asset("assets/images/no_circular.svg",
            width: size, height: size, fit: BoxFit.cover),
        AppGapping.padding10,
        Text(
          text,
          style: FontUtil.noCircular,
        ),      
      ],
    );
  }
  }