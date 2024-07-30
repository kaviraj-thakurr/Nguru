import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/assignment_models/assignment_month_list_model.dart';
import 'package:nguru/models/attendence_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/models/fees_model.dart';
import 'package:nguru/models/forget_pass_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';
import 'package:nguru/models/notification_models.dart';
import 'package:nguru/models/push_notification_model.dart';
import 'package:nguru/models/reset_password_model.dart';
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

  Future<ForgetPassWordModel> forgotPassword(String userName) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com/mobileappservice/Api/SignIn/ForgetPassword",
          data: {
            "deviceToken":
                "egHYgbv1QiqwROrA6TvcKf:APA91bFdMzQfCILVclHscc9PmRT1eQHHdG62PNNLsI78pWvkbKjlFzEU3BgZuOvIHJrLo7yoyUNHPpE3s5c33Rsil7mIoAQpTlIiEzbrAfmuCNibeRIb4kGeLo82_mJBZ5OWugcg63S8",
            "deviceType": "1",
            "password": "",
            "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
            "userName": userName
          });
      var result = ForgetPassWordModel.fromJson(json.decode(res.toString()));
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

  Future<AttendenceModel> fetchAttendanceData() async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://qsstg.niiteducation.com/mobileappservice/Api/Attendance/GetCumulativeAttendance",
        data: {
          
            "userID": 118011,
            "schoolID": 1,
            "studentID": 106045,
            "sessionID": 178,
            "schoolURL": "https://qsstg.iiteducation.com/tistnj",
            "pageNumber": 0
          
        },
      );

      var result = AttendenceModel.fromJson(json.decode(res.toString()));
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }

  ////////////////////////////////////////////////     ASSIGNMENT STORY       //////////////////////////////////////////////////////

  Future<AssignmentsMonthList> getAssignementMonthList({
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com:443/mobileappservice/Api/Assignment/GetCalenderList/",
        data: {
          "appMessageID": 0,
          "circularID": 0,
          "contentType": 0,
          "downloadAttachment": 0,
          "isNotification": 0,
          "messageTypeId": 0,
          "month": 7,
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
      AssignmentsMonthList assignmentsMonthList =
          assignmentsMonthListFromJson(res.toString());
      return assignmentsMonthList;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     ASSIGNMENT STORY ON TAP      //////////////////////////////////////////////////////

  Future<AssignmentList> getAssignementList({
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com:443/mobileappservice/Api/Assignment/GetAssignmentList/",
        data: {
          "appMessageID": 0,
          "assignmentDate": "2024-07-17T00:00:00",
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
        },
      );
      AssignmentList assignmentsMonthList =
          assignmentListFromJson(res.toString());
      return assignmentsMonthList;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     CIRCULAR STORY ON TAP      //////////////////////////////////////////////////////

  Future<CircularModel> getCurrentCircular({
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com:443/mobileappservice/Api/Circular/GetMainList/",
        data: {
          "appMessageID": 0,
          "circularID": 0,
          "contentType": 0,
          "downloadAttachment": 0,
          "isNotification": 0,
          "messageTypeId": 0,
          "month": 0,
          "pageNumber": 1,
          "pageSize": 10,
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
      CircularModel currentCircularList = circularModelFromJson(res.toString());
      return currentCircularList;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     Dicipline STORY ON TAP      //////////////////////////////////////////////////////

  Future<DisciplineModel> getCurrentDicipline({
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com:443/mobileappservice/Api/Discipline/GetList/",
        data: {
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
        },
      );
      DisciplineModel currentDiciplineList =
          disciplineModelFromJson(res.toString());
      return currentDiciplineList;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     CONTACT US      //////////////////////////////////////////////////////

  Future<ContactUs> contactUs({
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
        url:
            "https://quickschool.niitnguru.com:443/mobileappservice/Api/ContactUs/GetContact/",
        data: {
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
        },
      );
      ContactUs contactUsResponse = contactUsFromJson(res.toString());
      return contactUsResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     Gallery API      //////////////////////////////////////////////////////

  Future<GalleryPhotosModel> getGalleryPhotoList({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://qsstg.niiteducation.com/mobileappservice/Api/PhotoGallery/GetList/",
          data: {
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
            "schoolUrl": "https://qsstg.niiteducation.com/tistnj",
            "sessionID": 178,
            "studentID": 106045,
            "subjectID": 0,
            "type": 0,
            "userID": "112968",
            "year": 0
          });
      GalleryPhotosModel galleryPhotoResponse =
          galleryPhotosModelFromJson(res.toString());
      return galleryPhotoResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     SIGNOUT API      //////////////////////////////////////////////////////

  Future<Map<String, String>> signout({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com/mobileappservice/Api/SignIn/Logout/",
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "deviceToken":
                "cWG3o3r8R-WRIDh0lqWcGJ:APA91bG1WdxTuuYeiQkbbIN-24cCiejfBKFsU0x_2vde55fINGSoOGZmXD-479iD--hAJLJj4fOp_O2T9bydOL46zwy8q7nyfioUm3zFBogwW2QHXWo1XQEQZ4xYE-LOghv16MxHto93",
            "deviceType": "1",
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": 0,
            "month": 0,
            "pageNumber": 0,
            "pageSize": 0,
            "schoolID": 1,
            "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
            "sessionID": 58,
            "studentID": 888,
            "subjectID": 0,
            "type": 0,
            "userID": "6135",
            "year": 0
          });
      Map<String, String> signoutResponse = res;
      return signoutResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to logout: $e");
    }
  }

  ////////////////////////////////////////////////     REST PASSWORD API      //////////////////////////////////////////////////////

  Future<ResetPasswordModel> resetPassword({
    int? pageNumber,
    required String? newPassword,
    required String? oldPassword,
  }) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com:443/mobileappservice/Api/ChangePassword/Update",
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": 0,
            "month": 0,
            "newPassword": "$newPassword",
            "oldPassword": "$oldPassword",
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
      ResetPasswordModel resetResponse =
          resetPasswordModelFromJson(res.toString());
      return resetResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to logout: $e");
    }
  }

  ////////////////////////////////////////////////     PUSH NOTIFICATION API      //////////////////////////////////////////////////////

  Future<PushNotificationModel> pushNotification({
    int? pageNumber,
    required int? isNotification,
  }) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com:443/mobileappservice/Api/ChangePassword/Update",
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "deviceToken":
                "egHYgbv1QiqwROrA6TvcKf:APA91bFdMzQfCILVclHscc9PmRT1eQHHdG62PNNLsI78pWvkbKjlFzEU3BgZuOvIHJrLo7yoyUNHPpE3s5c33Rsil7mIoAQpTlIiEzbrAfmuCNibeRIb4kGeLo82_mJBZ5OWugcg63S8",
            "deviceType": "1",
            "downloadAttachment": 0,
            "isNotification": isNotification,
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
      PushNotificationModel pushNotificationResponse =
          pushNotificationModelFromJson(res.toString());
      return pushNotificationResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to logout: $e");
    }
  }

  ////////////////////////////////////////////////     FEES API      //////////////////////////////////////////////////////

  Future<FeesModel> getTotalFees({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          url:
              "https://quickschool.niitnguru.com/mobileappservice/Api/Fee/GetList/",
          data: {
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
          });
      FeesModel feeResponse = feesModelFromJson(res.toString());
      return feeResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }
}
