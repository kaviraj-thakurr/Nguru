import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///use for font Size
const double fontExtraSmall = 8;
const double fontSmall = 10;
const double fontMedium = 12;
const double fontMediumLarge = 13;
const double fontNormal = 14;
const double fontNormalLarge = 15;
const double fontLarge = 16;
const double fontSize17 = 17;
const double fontExtraExtraLarge = 24;
const double fontSizeHeader = 20;
const double fontSize13 = 13;
const double fontSize32 = 32;

const double fontExtraLarge = 18;

/// use for height width
const double depthExtraSmall = 2;
const double depthSmall = 4;
const double depthMedium = 6;
const double depthNormal = 8;
const double depthLarge = 10;
const double depthExtraLarge = 12;
const double depth30 = 30;
const double depth40 = 40;
const double depth80 = 80;

/// use for circular radius
const double radiusExtraSmall = 2;
const double radiusSmall = 4;
const double radiusXmedium = 5;
const double radius5 = 5;
const double radiusMedium = 6;
const double radiusNormal = 8;
const double radius9 = 9;
const double radiusLarge = 10;
const double radiusExtraLarge = 12;
const double radiusRegularLarge = 20;
const double radius25 = 25;
const double radius15 = 15;
const double radius20 = 20;
const double radius40 = 40;
const double radius26 = 26;
const double radius16 = 16;
const double radius30 = 30;
const double radius35 = 35;
const double radius100 = 100;
const double raduis14 = 14;
const double raduis19 = 19;
const double raduis48 = 48;

/// use for padding
const double paddingZero = 0;
const double paddingExtraSmall = 2;
const double paddingNormalSmall = 3;
const double padding2_5 = 2.5;
const double padding0_5 = 0.5;
const double paddingSmall = 4;
const double paddingRegularSmall = 5;
const double paddingSmallMedium = 5;
const double paddingMedium = 6;
const double padding6_5 = 6.5;
const double paddingExtraMedium = 7;
const double paddingNormal = 8;
const double paddingLarge = 10;
const double paddingExtraLarge = 12;
const double paddingSize14 = 14;
const double paddingNormalRegularLarge = 15;
const double paddingRegularLarge = 16;
const double paddingExtraRegularLarge = 20;
const double paddingSize18 = 18;
const double paddingSize20 = 20;
const double paddingRegularLarge18 = 18;


const double padding8 = 8.0;
const double padding13 = 13;
const double padding18 = 18;
const double padding19 = 19;
const double padding20 = 20;
const double padding24 = 24;
const double padding26 = 26;
const double padding28 = 28;
const double padding30 = 30;
const double padding32 = 32;
const double padding40 = 40;
const double padding45 = 45;
const double padding72 = 72;
const double padding65 = 65;
const double padding23 = 23;
const double padding27 = 27;
const double padding92 = 92;

/// use for margin
const double marginExtraSmall = 2;
const double marginSmall = 4;
const double marginMedium = 6;
const double marginNormal = 8;
const double marginLarge = 10;
const double marginExtraLarge = 8;
const double marginRegularLarge = 16;
const double marginExtraRLarge = 12;
const double marginExtraExtraLarge = 20;
const double marginExtraLargest = 30;
const double margin35 = 35;
const double margin37 = 37;
const double margin12 = 12;
const double margin18 = 18;
const double margin20 = 20;
const double margin24 = 24;
const double margin26 = 26;
const double margin28 = 28;
const double margin30 = 30;

// This is where the magic happens.
// This functions are responsible to make UI responsive across all the mobile devices.

Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;

// Caution! If you think these are static values and are used to build a static UI,  you mustn’t.
// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 360;
const num FIGMA_DESIGN_HEIGHT = 800;
const num FIGMA_DESIGN_STATUS_BAR = 24;

///This method is used to get device viewport width.
get width {
  return size.width;
}

///This method is used to get device viewport height.
get height {
  num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  num screenHeight = size.height - statusBar;
  return screenHeight;
}

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(double px) {
  return ((px * width) / FIGMA_DESIGN_WIDTH).floorToDouble();
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  return ((px * height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR))
      .floorToDouble();
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return getSize(px);
}

///This method is used to set padding responsively
EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to get padding or margin responsively
EdgeInsetsGeometry getMarginOrPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: getHorizontalSize(
      left ?? 0,
    ),
    top: getVerticalSize(
      top ?? 0,
    ),
    right: getHorizontalSize(
      right ?? 0,
    ),
    bottom: getVerticalSize(
      bottom ?? 0,
    ),
  );
}

EdgeInsetsGeometry padding16 = EdgeInsets.fromLTRB(16, 16, 16, 16);
EdgeInsetsGeometry padding16pts10 = EdgeInsets.fromLTRB(16, 10, 10, 16);
EdgeInsetsGeometry paddingOnly2pt5 = EdgeInsets.only(top: 2.5, bottom: 2.5);
EdgeInsetsGeometry paddingOnly20 = EdgeInsets.only(top: 20);
EdgeInsetsGeometry padding59LR = EdgeInsets.fromLTRB(20, 0, 20, 0);
