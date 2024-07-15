import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_assets.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final Widget? floatingAction;
  final dynamic onPopInvoked;

  const CustomScaffold(
      {super.key, required this.child, this.floatingAction, this.onPopInvoked});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              MyAssets.background,
              fit: BoxFit.cover,
              height: screenHeight,
            ),
          ),
          PopScope(
            onPopInvoked: onPopInvoked,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: child,
              floatingActionButton: floatingAction,
            ),
          )
        ],
      ),
    );
  }
}