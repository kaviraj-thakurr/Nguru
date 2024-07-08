import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/utils/my_colors.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: personInfoCard(context)
      ),
    );
  }
}
