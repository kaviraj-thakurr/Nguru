import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nguru/models/attendence_model.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/models/notification_models.dart';
import 'package:nguru/services/networking.dart';
import 'package:nguru/utils/app_const.dart';

import 'package:nguru/models/add_school_model.dart';
import 'package:nguru/models/login_model.dart';

class AuthRepo {
  final _myService = Networking();
  var userToken = "";

  //------------------------------------this api method for add school screen---------> //

  Future<AddSchoolModel> addSchool(String schoolurl, String subDomain) async {
    String fullSchoolUrl = "$schoolurl$subDomain";

    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com/mobileappservice/Api/School/GetDetail/",
        data: {
          "schoolURL": fullSchoolUrl,
        },
      );
      AddSchoolModel addSchool = addSchoolFromJson(res.toString());
      return addSchool;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to add school: $e");
    }
  }

  //--------------------------------this api method for login screen------------->//

  Future<LoginModel> logIn(
      {String? deviceToken,
      String? deviceType,
      required String password,
      String? schoolUrl,
      required String userName}) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com/mobileappservice/Api/SignIn/Login/",
        data: {
          "schoolURL": "https://quickschool.niitnguru.com/demoschool",
          "deviceToken":
              "cWG3o3r8R-WRIDh0lqWcGJ:APA91bG1WdxTuuYeiQkbbIN-24cCiejfBKFsU0x_2vde55fINGSoOGZmXD-479iD--hAJLJj4fOp_O2T9bydOL46zwy8q7nyfioUm3zFBogwW2QHXWo1XQEQZ4xYE-LOghv16MxHto93",
          "deviceType": "1",
          "password": password,
          "userName": userName
        },
      );
      LoginModel logInData = loginModelFromJson(res.toString());
      return logInData;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  //--------------------------this method for forgot password------------>//

  Future<dynamic> forgotPassword(String userName) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com/mobileappservice/Api/SignIn/ForgetPassword",
          data: {"userName": userName});
      var result = json.decode(res.toString());
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  //-----------------------------this api method for dashboard Sreen----------->//

  Future<DashboardModel> dashboardGetList() async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com/mobileappservice/Api/Dashboard/GetList/",
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "deviceType": "1",
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": 0,
            "month": 0,
            "pageNumber": 0,
            "pageSize": 0,
            "schoolID": 1,
            "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
            "sessionID": 107,
            "studentID": 896,
            "subjectID": 0,
            "type": 0,
            "userID": "6135",
            "year": 0
          });
      var result = DashboardModel.fromJson(json.decode(res.toString()));
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }

  ///-------------------this api method for notification count ----------------->

  Future<NotificationModel> notificationCount() async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com/mobileappservice/Api/Notification/Count/",
        data: {
          "appMessageID": 0,
          "circularID": 0,
          "contentType": 0,
          "deviceToken":
              "egHYgbv1QiqwROrA6TvcKf:APA91bFdMzQfCILVclHscc9PmRT1eQHHdG62PNNLsI78pWvkbKjlFzEU3BgZuOvIHJrLo7yoyUNHPpE3s5c33Rsil7mIoAQpTlIiEzbrAfmuCNibeRIb4kGeLo82_mJBZ5OWugcg63S8",
          "deviceType": "1",
          "downloadAttachment": 0,
          "isNotification": 0,
          "messageTypeId": 0,
          "month": 0,
          "pageNumber": 0,
          "pageSize": 0,
          "schoolID": 1,
          "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
          "sessionID": 107,
          "studentID": 896,
          "subjectID": 0,
          "type": 0,
          "userID": "6135",
          "year": 0
        },
      );
      var result = NotificationModel.fromJson(json.decode(res.toString()));
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }

  Future<AttendanceData> fetchAttendanceData() async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com/mobileappservice/Api/Attendance/GetBarChart/",
        data: {
          {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": 0,
            "month": 0,
            "pageNumber": 0,
            "pageSize": 0,
            "schoolID": 1,
            "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
            "sessionID": 107,
            "studentID": 896,
            "subjectID": 0,
            "type": 0,
            "userID": "6135",
            "year": 0
          }
        },
      );

      var result = AttendanceData.fromJson(json.decode(res.toString()));
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }
}
