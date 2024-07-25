import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';

class CustomProgressBar extends StatefulWidget {
  final double progress;
  final int dotCount;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.dotCount = 5,
  });


  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(CustomProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: oldWidget.progress, end: widget.progress).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 8),
      decoration: BoxDecoration(
         color: MyColors.borderColor,
        //gradient :MyColors.buttonColors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * _animation.value,
                decoration: BoxDecoration(
                  gradient: MyColors.arrowColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.dotCount, (index) {
                return Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: index <= (_animation.value * widget.dotCount).floor() ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
