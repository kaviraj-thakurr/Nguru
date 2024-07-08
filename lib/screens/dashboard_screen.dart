import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';

class NguruDashboardScreen extends StatefulWidget {
  const NguruDashboardScreen({super.key});

  @override
  State<NguruDashboardScreen> createState() => _NguruDashboardScreenState();
}

class _NguruDashboardScreenState extends State<NguruDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dashboardAppBar(),

    );
  }
}