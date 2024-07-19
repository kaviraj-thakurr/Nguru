// Updated Dashboard State classes
import 'package:nguru/models/dashboard_model.dart';

abstract class DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final String? studentName;
  final String? studentPicture;
  final String? qualification;
  final String? admissionNumber;
  final String? section;
  final String ? dashboardItem;
 final List<Map<String, String>> ? dashboardList;

  DashboardSuccessState({
    this.studentName,
    this.studentPicture,
    this.qualification,
    this.admissionNumber,
    this.section,
    this.dashboardItem,
    this.dashboardList,
  });
}

class DashboardErrorState extends DashboardState {
  final String message;
  
  DashboardErrorState(this.message);
}






