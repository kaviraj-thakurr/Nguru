import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nguru/models/activity_model.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/assignment_models/assignment_month_list_model.dart';
import 'package:nguru/models/attendance_bar_chart_model.dart';
import 'package:nguru/models/attendence_model.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/models/change_siblings_model.dart';
import 'package:nguru/models/change_session_model.dart';
import 'package:nguru/models/chatMessagesList.dart';
import 'package:nguru/models/chatsend_button_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/communication_models.dart';
import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/cumulative_attendance_model.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/models/examMarksModel.dart';
import 'package:nguru/models/exam_sehedule_model.dart';
import 'package:nguru/models/fees_model.dart';
import 'package:nguru/models/forget_pass_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';
import 'package:nguru/models/gallery/get_gallery_list_model.dart';
import 'package:nguru/models/get_fee_model.dart';
import 'package:nguru/models/infirmary_model.dart';
import 'package:nguru/models/library_book_search_model.dart';
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';
import 'package:nguru/models/notification_models.dart';
import 'package:nguru/models/particular_month_attendance_model.dart';
import 'package:nguru/models/push_notification_model.dart';
import 'package:nguru/models/report_card_model.dart';
import 'package:nguru/models/reset_password_model.dart';
import 'package:nguru/models/reset_password_policy_model.dart';
import 'package:nguru/models/timetable_model.dart';
import 'package:nguru/models/transport_detail_model.dart';
import 'package:nguru/models/vaccination_model.dart';
import 'package:nguru/services/end_url.dart';
import 'package:nguru/services/networking.dart';

import 'package:nguru/models/add_school_model.dart';
import 'package:nguru/models/login_model.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

import '../models/notificationlist_model.dart';

//var schoolUrl = "";

class AuthRepo {
  final _myService = Networking();
  var userToken = "";

  String schoolUrl = "https://quickschool.niitnguru.com/demoschool";

  //------------------------------------this api method for add school screen---------> //

  Future<AddSchoolModel> addSchool(String schoolurl, String subDomain,String schoolNickName) async {
    String fullSchoolUrl = "$schoolurl$subDomain";

    try {
      await SharedPref.saveSchoolUrl(fullSchoolUrl);
       await SharedPref.saveTrimmedUrl(schoolurl);
      await SharedPref.saveSubDomain(subDomain);
       await SharedPref.saveSchoolNickName(schoolNickName);
      final res = await _myService.networkPost(
        url: EndUrl.addSchool,
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

  //  --------------------------------this api method for login screen------------->  //

  Future<LoginModel> logIn(
      {String? deviceToken,
      String? deviceType,
      required String password,
      String? schoolUrl,
      required String userName}) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.signInStaging, isStagingLink: true, data: {
        "schoolURL": schoolUrl,
        // "deviceToken":
        //     "cWG3o3r8R-WRIDh0lqWcGJ:APA91bG1WdxTuuYeiQkbbIN-24cCiejfBKFsU0x_2vde55fINGSoOGZmXD-479iD--hAJLJj4fOp_O2T9bydOL46zwy8q7nyfioUm3zFBogwW2QHXWo1XQEQZ4xYE-LOghv16MxHto93",
        "deviceType": "1",
        "password": password,
        "userName": userName
      });
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
      final res =
          await _myService.networkPost(
            isStagingLink: true,
            url: EndUrl.forgetPassword,
             data: {
        "deviceToken":
            "egHYgbv1QiqwROrA6TvcKf:APA91bFdMzQfCILVclHscc9PmRT1eQHHdG62PNNLsI78pWvkbKjlFzEU3BgZuOvIHJrLo7yoyUNHPpE3s5c33Rsil7mIoAQpTlIiEzbrAfmuCNibeRIb4kGeLo82_mJBZ5OWugcg63S8",
        "deviceType": "1",
        "password": "",
        "schoolUrl": await SharedPref.getSchoolUrl(),
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
        isStagingLink: true,
        url: EndUrl.dashboardList,
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
          "schoolID": await SharedPref.getSchoolID(),
          "schoolUrl": await SharedPref.getSchoolUrl(),
          "sessionID": await SharedPref.getSessionId(),
          "studentID": await SharedPref.getStudentID(),
          "subjectID": 0,
          "type": 0,
          "userID": await SharedPref.getUserID(),
          "year": 0
        },
      );
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
        isStagingLink: true,
        url: EndUrl.notificationCount,
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
          "schoolID": await SharedPref.getSchoolID(),
          "schoolUrl": await SharedPref.getSchoolUrl(),
          "sessionID": await SharedPref.getSessionId(),
          "studentID": await SharedPref.getSchoolID(),
          "subjectID": 0,
          "type": 0,
          "userID": await SharedPref.getUserID(),
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

  Future<AttendanceModel> fetchAttendanceData() async {
    try {
      final res = await _myService.networkPost(
        isStagingLink: true,
        url: EndUrl.attendance,
        data: {
          "userID": await SharedPref.getUserID(),
          "schoolID": await SharedPref.getSchoolID(),
          "studentID": await SharedPref.getStudentID(),
          "sessionID": await SharedPref.getSessionId(),
          "schoolURL": await SharedPref.getSchoolUrl(),
          "pageNumber": 0
        },
      );

      var result = AttendanceModel.fromJson(json.decode(res.toString()));
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
    int? month,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.assignmentCalendarList,
          isStagingLink: true,
          data: {
            "month": month,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 1
          });
      AssignmentsMonthList assignmentsMonthList =
          assignmentsMonthListFromJson(res.toString());
      return assignmentsMonthList;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     ASSIGNMENT STORY ON TAP      //////////////////////////////////////////////////////

  Future<AssignmentList> getAssignementList({
    String? deviceToken,
    String? deviceType,
    int? month,
    String? assignmentOnParticularDate,
    //  required String password,
    String? schoolUrl,
    // required String userName  "2024-08-14T00:00:00"  "2024-08-14T00:00:00"
  }) async {
    try {
      final res = await _myService
          .networkPost(isStagingLink: true, url: EndUrl.assignmentList, data: {
        "appMessageID": 0,
        "assignmentDate": "$assignmentOnParticularDate",
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "pageNumber": 0,
        "pageSize": 0,
        "schoolID": await SharedPref.getSchoolID(),
        "schoolUrl": await SharedPref.getSchoolUrl(),
        "sessionID": await SharedPref.getSessionId(),
        "studentID": await SharedPref.getStudentID(),
        "subjectID": 0,
        "type": 0,
        "userID": await SharedPref.getUserID(),
        "year": 0
      });
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
    int? month,
    String? deviceType,
    String? page,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.currentCircularList,
          data: {
            // "circularID": 1,
            "month": month,
            "type": 1,
            "pageSize": 1000,
            // "pageNumber": 0,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
          });
      CircularModel currentCircularList = circularModelFromJson(res.toString());
      return currentCircularList;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  ////////////////////////////////////////////////     Dicipline STORY ON TAP      //////////////////////////////////////////////////////

  Future<DisciplineModel> getCurrentDicipline({
    int? type,
    String? deviceToken,
    String? deviceType,
    //  required String password,
    String? schoolUrl,
    // required String userName
  }) async {
    // type =1 for fetching all the discipline liist

    try {
      final res = await _myService.networkPost(
        isStagingLink: true,
        url: EndUrl.currentDisciplineList,
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
          "schoolID": await SharedPref.getSchoolID(),
          "schoolUrl": await SharedPref.getSchoolUrl(),
          "sessionID": await SharedPref.getSessionId(),
          "studentID": await SharedPref.getStudentID(),
          "subjectID": 0,
          "type": type ?? 0,
          "userID": await SharedPref.getUserID(),
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
        isStagingLink: true,
        url: EndUrl.contactUs,
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
          "schoolID": await SharedPref.getSchoolID(),
          "schoolUrl": await SharedPref.getSchoolUrl(),
          "sessionID": await SharedPref.getSessionId(),
          "studentID": await SharedPref.getStudentID(),
          "subjectID": 0,
          "type": 0,
          "userID": await SharedPref.getUserID(),
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

  ////////////////////////////////////////////////      GALLERY ITEMS LIST API      //////////////////////////////////////////////////////

  Future<GalleryItemListModel> getGalleryItemList({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.photoGalleryList,
          data: {
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSessionId(),
            "studentID": await SharedPref.getStudentID(),
            "userID": await SharedPref.getUserID(),
            "pageNumber": 0
          });
      GalleryItemListModel galleryPhotoResponse =
          galleryItemListModelFromJson(res.toString());
      return galleryPhotoResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch gallery items list: $e");
    }
  }

  ////////////////////////////////////////////////     PARTICULAR GALLERY ITEM PHOTOS API      //////////////////////////////////////////////////////

  Future<GalleryPhotosModel> getGalleryPhotoList({
    int? dashPictureGalleryId,
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.photoGalleryGetDetList,
          data: {
            "schoolID": await SharedPref.getSchoolID(),
            "dashPictureGalleryId": dashPictureGalleryId,
            "schoolURL": await SharedPref.getSchoolUrl(),
          });
      GalleryPhotosModel galleryPhotoResponse =
          galleryPhotosModelFromJson(res.toString());
      return galleryPhotoResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to login: $e");
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
          url: EndUrl.changeUpdatePassword,
          isStagingLink: true,
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
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSchoolUrl(),
            "studentID": await SharedPref.getSessionId(),
            "subjectID": 0,
            "type": 0,
            "userID": await SharedPref.getUserID(),
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



    ////////////////////////////////////////////////     REST PASSWORD API      //////////////////////////////////////////////////////

String cleanJsonString(String str) {
  // Replace single quotes around keys with double quotes
  str = str.replaceAllMapped(
    RegExp(r'(\w+):'), (match) => '"${match.group(1)}":'
  );

  // Replace single quotes around string values with double quotes
  str = str.replaceAllMapped(
    RegExp(r'(?<=:\s*)(\w+)(?=,|\}|\s)'), (match) => '"${match.group(1)}"'
  );

  return str;
}

Future<List<ResetPasswordPolicyModel>> getResetPasswordPolicy({
  int? pageNumber,
}) async {
  try {
    // Make the network request
    final res = await _myService.networkPost(
      url: EndUrl.changePasswordPolicy,
      isStagingLink: true,
      data: {
        "userID": await SharedPref.getUserID(),
        "schoolID": await SharedPref.getSchoolID(),
        "studentID": await SharedPref.getStudentID(),
        "sessionID": await SharedPref.getSessionId(),
        "schoolURL": await SharedPref.getSchoolUrl(),
      },
    );

    // Extract the response body and clean it
    final responseBody = res.data.toString();
    final cleanedResponseBody = cleanJsonString(responseBody);

    // Log the cleaned response for debugging
    log(cleanedResponseBody);

    // Parse the cleaned JSON string into a list of ResetPasswordPolicyModel
    List<ResetPasswordPolicyModel> resetResponse =
        resetPasswordPolicyModelFromJson(cleanedResponseBody);

    return resetResponse;
  } catch (e) {
    log(e.toString());
    throw Exception("Failed to get reset password policy: $e");
  }
}




  ////////////////////////////////////////////////     FEES API      //////////////////////////////////////////////////////

  Future<FeesModel> getTotalFees(
      // int? pageNumber,
      ) async {
    try {
      final res = await _myService
          .networkPost(isStagingLink: true, url: EndUrl.fees, data: {
        "appMessageID": 0,
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": 0,
        "pageNumber": 0,
        "pageSize": 0,
        "schoolID": await SharedPref.getSchoolID(),
        "schoolUrl": await SharedPref.getSchoolUrl(),
        "sessionID": await SharedPref.getSessionId(),
        "studentID": await SharedPref.getStudentID(),
        "subjectID": 0,
        "type": 0,
        "userID": await SharedPref.getUserID(),
        "year": 0
      });
      FeesModel feeResponse = feesModelFromJson(res.toString());
      return feeResponse;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  ///////////////////////TIMETABEL SCREEEN API////////////////////////////////////////////

  Future<TimeTableModel> getTimeTableList() async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.timeTable, isStagingLink: true, data: {
        "appMessageID": 0,
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": 0,
        "pageNumber": 0,
        "pageSize": 0,
        "schoolID": await SharedPref.getSchoolID(),
        "schoolUrl": await SharedPref.getSchoolUrl(),
        "sessionID": await SharedPref.getSessionId(),
        "studentID": await SharedPref.getStudentID(),
        "subjectID": 0,
        "type": 0,
        "userID": await SharedPref.getUserID(),
        "year": 0
      });
      TimeTableModel timeTableModel = timeTableModelFromJson(res.toString());
      return timeTableModel;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  //////////////////////////////////////////////NOTIFICATION SCREEN LIST ///////////////////////////////////
  Future<NotificationListModel> getNotificationList() async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.notificationList,
          isStagingLink: true,
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
            "pageNumber": 1,
            "pageSize": 2000,
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSessionId(),
            "studentID": await SharedPref.getStudentID(),
            "subjectID": 0,
            "type": 0,
            "userID": await SharedPref.getUserID(),
            "year": 0
          });
      NotificationListModel notificationListModel =
          notificationListModelFromJson(res.toString());
      return notificationListModel;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  //////////////////////////////////////////////////TRANSPORT DETAILS ///////////////////////////////////////////////////////
  Future<TransportDetails> getTransportDetails() async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.transportDetails,
          isStagingLink: true,
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
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSessionId(),
            "studentID": await SharedPref.getStudentID(),
            "subjectID": 0,
            "type": 0,
            "userID": await SharedPref.getStudentID(),
            "year": 0
          });
      TransportDetails transportDetails =
          transportDetailsFromJson(res.toString());
      return transportDetails;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  Future<CommunicationModel> getCommunicationDetails() async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.communicationDetails,
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": 0,
            "month": 0,
            "pageNumber": 1,
            "pageSize": 100,
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSessionId(),
            "studentID": await SharedPref.getStudentID(),
            "subjectID": 0,
            "type": 0,
            "userID": await SharedPref.getUserID(),
            "year": 0
          });
      CommunicationModel communicationModel =
          communicationModelFromJson(res.toString());
      return communicationModel;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  Future<ChatSendButton> sendMessageButton(
      String? message, int? appMessageID) async {
    try {
      final res = await _myService.networkPost(url: EndUrl.sendMessage,isStagingLink: true, 
      data:
    {
	"appMessageID":appMessageID,
	"circularID":0,
	"content":message,
	"contentType":0,
	"createdForUserId":"114989",
	"downloadAttachment":0,
	"isNotification":0,
	"messageTypeId":0,
	"month":0,
	"pageNumber":0,
	"pageSize":0,
	"schoolID":await SharedPref.getSchoolID(),
	"schoolUrl":await SharedPref.getSchoolUrl(),
	"sessionID":await SharedPref.getSessionId(),
	"studentID":await SharedPref.getStudentID(),
	"subjectID":0,
	"type":0,
	"userID":await SharedPref.getUserID(),
	"year":0
}

      );
      
      ChatSendButton chatSendButton = chatSendButtonFromJson(res.toString());
      return chatSendButton;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get total fee: $e");
    }
  }

  ////////////////////////////////////////////////     GET ATTENDANCE BAR CHART DATA      //////////////////////////////////////////////////////

  Future<AttendanceBarChartModel> getAttendanceBarGraph({
    int? pageNumber,
    int? isNotification,
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.attendanceGetBarChart,
          data: {
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 1
          });
      AttendanceBarChartModel attendanceBarChartDataResponse =
          attendanceBarChartModelFromJson(res.toString());
      return attendanceBarChartDataResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to get attendance bar chart data: $e");
    }
  }

  ////////////////////////////////////////////////     GET PARTICULAR MONTH DATA      //////////////////////////////////////////////////////

  Future<ParticularMonthAttendanceModel> getParticularMonthAttendance({
    int? monthNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.attendanceGetMonthWise,
          data: {
            "month": monthNumber,
            "year": 2024,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 1
          });
      ParticularMonthAttendanceModel particularMonthAttendanceDataResponse =
          particularMonthAttendanceModelFromJson(res.toString());
      return particularMonthAttendanceDataResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch particular moonth attendance data: $e");
    }
  }

  ////////////////////////////////////////////////     GET FEE LIST DATA      //////////////////////////////////////////////////////

  Future<GetFeeListModel> getFeeList() async {
    try {
      final res = await _myService
          .networkPost(isStagingLink: true, url: EndUrl.feeGetList, data: {
        "pageNumber": 0,
        "pageSize": 0,
        "schoolID": await SharedPref.getSchoolID(),
        "schoolUrl": await SharedPref.getSchoolUrl(),
        "sessionID": await SharedPref.getSessionId(),
        "studentID": await SharedPref.getStudentID(),
        "type": 0,
        "userID": await SharedPref.getUserID(),
        "year": 0
      });
      GetFeeListModel getFeeListModelResponse =
          getFeeListModelFromJson(res.toString());
      return getFeeListModelResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch fee list: $e");
    }
  }

  ////////////////////////////////////////////////     GET FEE LIST DATA      //////////////////////////////////////////////////////

  Future<DisciplineModel> getDisciplineList({int? type}) async {
    // type = 1 for fetching all the discipline
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.diciplineGetList,
          data: {
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 0
          });
      DisciplineModel disciplineModelResponse =
          disciplineModelFromJson(res.toString());
      return disciplineModelResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch discipline list: $e");
    }
  }

  ////////////////////////////////////////////////     GET CALENDAR EVENT LIST DATA      //////////////////////////////////////////////////////

  Future<CalendarEventModel> getCalendarEventList({int? monthNumber}) async {
    // type = 1 for fetching all the discipline
    try {
      final res = await _myService.networkPost(
          url: EndUrl.calendarEventGetList,
          isStagingLink: true,
          data: {
            "month": monthNumber,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 7
          });
      CalendarEventModel calendarEventModelResponse =
          calendarEventModelFromJson(res.toString());
      return calendarEventModelResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch calendar events list: $e");
    }
  }

  ////////////////////////////////////////////////      LIBRARY      //////////////////////////////////////////////////////

  Future<LibraryIssuedBookModel> getLibraryIssuedBook() async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.libraryGetIssuedList,
          data: {
            "bookID": 1,
            "accessionNo": 1,
            "issueReturnId": 1,
            "type": 1,
            "pageSize": 1000,
            "pageNumber": 1,
            "userID": await SharedPref.getUserID(),
            "schoolID": 1,
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl()
          });
      LibraryIssuedBookModel libraryIssuedBookListResponse =
          libraryIssuedBookModelFromJson(res.toString());
      return libraryIssuedBookListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library issued books list: $e");
    }
  }

// LIBRARY HISTORY

  Future<LibraryHistoryModel> getLibraryHistory({int? monthNumber}) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.libraryGetHistoryList,
          data: {
            "type": 1,
            "pageSize": 1000,
            "pageNumber": 1,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl()
          });
      LibraryHistoryModel libraryHistoyListResponse =
          libraryHistoryModelFromJson(res.toString());
      return libraryHistoyListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library histoy list: $e");
    }
  }


  
  ////////////////////////////CHANGE SIBLINGS //////////////////////////


Future<ChangeSiblingsModel> getSiblingsList() async {
    try {
      final res =
          await _myService.networkPost(
            url: EndUrl.changeSiblings,
            isStagingLink: true,
             data: {
 
  "userID":  await SharedPref.getUserID(),
  "schoolID":  await SharedPref.getSchoolID(),
  "studentID":  await SharedPref.getStudentID(),
  "sessionID":  await SharedPref.getSessionId(),
  "schoolURL":  await SharedPref.getSchoolUrl(),
});
      ChangeSiblingsModel changeSiblingsModel = changeSiblingsModelFromJson(res.toString());
      return changeSiblingsModel;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch siblings list: $e");
    }
  }


/////////////////////////// Exam Marks List //////////////////////////////

Future<ExamMarksModel> getExamMarks() async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.examMarksList,
          data: 
 {

 "userID":await SharedPref.getUserID(),
  "schoolID": await SharedPref.getSchoolID(),
 "studentID":await SharedPref.getStudentID(),
"sessionID":await SharedPref.getSessionId(),
 "schoolUrl":await SharedPref.getSchoolUrl(),
}
          );
      ExamMarksModel examMarksModel =
         examMarksModelFromJson(res.toString());
      return examMarksModel;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch gallery items list: $e");
    }
  }


  //////////////////////////////Report Card List ////////////////////////
  
 Future<ReportCardModel> getReportCardList() async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.reportCardList,
          data: 
     {
"appMessageID":0,
 "circularID":0,
  "contentType":0,
 "downloadAttachment":0,
  "isNotification":0,
"messageTypeId":0,
 "month":0,
"pageNumber":1,
 "pageSize":8,
 "schoolID":await SharedPref.getSchoolID(),
 "schoolUrl":await SharedPref.getSchoolUrl(),
 "sessionID":await SharedPref.getSessionId(),
"studentID":await SharedPref.getStudentID(),

"type":0,
 "userID":await SharedPref.getUserID(),
"year":0
}
          );
      ReportCardModel reportCardModel =
          reportCardModelFromJson(res.toString());
      return reportCardModel;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch gallery items list: $e");
    }
  }



///////////////////////////////// GET EXAM SCHEDULE LIST //////////////////////
  
Future<ScheduleModel> getScheduleList() async {
    try {
      final res =
          await _myService.networkPost(
            url: EndUrl.examScheduleList,
            isStagingLink: true,
             data: {
 
  "userID":  await SharedPref.getUserID(),
  "schoolID":  await SharedPref.getSchoolID(),
  "studentID":  await SharedPref.getStudentID(),
  "sessionID":  await SharedPref.getSessionId(),
  "schoolURL":  await SharedPref.getSchoolUrl(),
});
      ScheduleModel scheduleModel = scheduleModelFromJson(res.toString());
      return scheduleModel;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch schedule list: $e");
    }
  }


  // LIBRARY SEARCH

  Future<LibrarySearchBookModel> getLibrarySearchList(
      {String? searchQuery}) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.libraryGetSearchList,
          data: {
            "schoolURL": await SharedPref.getSchoolUrl(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "bookName": "",
            "keyword": "$searchQuery",
            "authorName": "",
            "pageSize": 1000,
            "pageNumber": 1,
            "sessionID": await SharedPref.getSessionId(),
          });
      LibrarySearchBookModel libraryHistoyListResponse =
          librarySearchBookModelFromJson(res.toString());
      return libraryHistoyListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library book search list: $e");
    }
  }



// RESERVE A BOOK

  Future<Map<String, String>> reserveBook(
      int? bookID, int? accessionNo, int? issueReturnId) async {
    try {
      // Making the POST request
      final response = await _myService.networkPost(
        isStagingLink: true,
        url: EndUrl.libraryReserveBook,
        data: {
          "bookID": bookID,
          "accessionNo": accessionNo,
          "issueReturnId": issueReturnId,
          "type": 1,
          "pageSize": 12,
          "pageNumber": 1,
          "userID": await SharedPref.getUserID(),
          "schoolID": await SharedPref.getSchoolID(),
          "studentID": await SharedPref.getStudentID(),
          "sessionID": await SharedPref.getSessionId(),
          "schoolURL": await SharedPref.getSchoolUrl(),
        },
      );
      Map<String, dynamic> res = response.data;
      Map<String, String> reservedResponse = {
        "responseCode": "${res["responseCode"]}",
        "responseMessage": "${res["responseMessage"]}"
      };

      return reservedResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch reserve book: $e");
    }
  }

  ////////////////////////////////////////////////      Comunication      //////////////////////////////////////////////////////

// RESERVE A BOOK

//   Future<Map<String,String>> reserveBook(int? bookID, int? accessionNo, int? issueReturnId) async {
//   try {
//     // Making the POST request
//     final response = await _myService.networkPost(
//       isStagingLink: true,
//       url: EndUrl.libraryReserveBook,
//       data: {
//         "bookID": bookID,
//         "accessionNo": accessionNo,
//         "issueReturnId": issueReturnId,
//         "type": 1,
//         "pageSize": 12,
//         "pageNumber": 1,
//         "userID": await SharedPref.getUserID(),
//         "schoolID": await SharedPref.getSchoolID(),
//         "studentID": await SharedPref.getStudentID(),
//         "sessionID": await SharedPref.getSessionId(),
//         "schoolURL": await SharedPref.getSchoolUrl(),
//       },
//     );
//     Map<String, dynamic> res = response.data;
//     Map<String,String> reservedResponse= {
//       "responseCode": "${res["responseCode"]}",
//       "responseMessage": "${res["responseMessage"]}"
//     };

//     return reservedResponse;
//   } catch (e) {
//     log(e.toString());
//     throw Exception("Failed to fetch reserve book: $e");
//   }
// }

  ////////////////////////////////////////////////      Comunication      //////////////////////////////////////////////////////

  Future<ListCommunicationModel> getCommunicationList(int? appMessageID) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.chatList, isStagingLink: true, data: {
        "appMessageID": appMessageID,
        "circularID": 0,
        "contentType": 0,
        "createdForUserId": "114989",
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": 0,
        "pageNumber": 1,
        "pageSize": 20,
        "schoolID": 1,
        "schoolUrl": "https://qsstg.niiteducation.com/tistnj",
        "sessionID": 178,
        "studentID": 108416,
        "subjectID": 0,
        "type": 0,
        "userID": "118011",
        "year": 0
      });
      ListCommunicationModel listCommunicationModel =
          listCommunicationModelFromJson(res.toString());
      return listCommunicationModel;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library book search list: $e");
    }
  }

  Future<Map<String, String>> saveMessageSubject(
      String subjectName, int messageTypeId) async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.saveMessageSubject,
          isStagingLink: true,
          data: {
            "appMessageID": 0,
            "circularID": 0,
            "contentType": 0,
            "createdForUserId": "114989",
            "downloadAttachment": 0,
            "isNotification": 0,
            "messageTypeId": messageTypeId,
            "month": 0,
            "pageNumber": 0,
            "pageSize": 0,
            "schoolID": await SharedPref.getSchoolID(),
            "schoolUrl": await SharedPref.getSchoolUrl(),
            "sessionID": await SharedPref.getSessionId(),
            "studentID": await SharedPref.getStudentID(),
            "subjectID": 0,
            "subjectName": subjectName,
            "type": 0,
            "userID": await SharedPref.getUserID(),
            "year": 0
          });

      Map<String, dynamic> response = res.data;
      Map<String, String> reservedResponse = {
        "responseCode": "${response["responseCode"]}",
        "responseMessage": "${response["responseMessage"]}"
      };
      return reservedResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library book search list: $e");
    }
  }

  ////////////////////////////////////////////////     GET INFIRMARY LIST DATA      //////////////////////////////////////////////////////

  Future<InfirmaryModel> getInfirmaryList() async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.infirmaryGetList,
          isStagingLink: true,
          data: {
            "pageSize": 1000,
            "pageNumber": 1,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
          });
      InfirmaryModel infirmaryResponse = infirmaryModelFromJson(res.toString());
      return infirmaryResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch infirmary list: $e");
    }
  }

  ////////////////////////////////////////////////     GET Vaccination LIST DATA      //////////////////////////////////////////////////////

  Future<VaccinationModel> getVaccinationList() async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.vaccinationGetList,
          isStagingLink: true,
          data: {
            "pageSize": 1000,
            "pageNumber": 1,
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
          });
      VaccinationModel vaccinationResponse =
          vaccinationModelFromJson(res.toString());
      return vaccinationResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch vaccination list: $e");
    }
  }

  ////////////////////////////////////////////////     GET ACTIVITY LIST DATA      //////////////////////////////////////////////////////

  Future<ActivityModel> getActivityList() async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.activityGetList, isStagingLink: true, data: {
        "pageSize": 1000,
        "pageNumber": 1,
        "userID": await SharedPref.getUserID(),
        "schoolID": await SharedPref.getSchoolID(),
        "studentID": await SharedPref.getStudentID(),
        "sessionID": await SharedPref.getSessionId(),
        "schoolURL": await SharedPref.getSchoolUrl(),
      });
      ActivityModel infirmaryResponse = activityModelFromJson(res.toString());
      return infirmaryResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch activity list: $e");
    }
  }

  ////////////////////////////////////////////////     GET Cumulative Attendance LIST       //////////////////////////////////////////////////////

  Future<CumulativeAttendanceModel> getCumulativeAttendance() async {
    try {
      final res = await _myService.networkPost(
          url: EndUrl.attendanceGetCumulativeAttendance,
          isStagingLink: true,
          data: {
            "userID": await SharedPref.getUserID(),
            "schoolID": await SharedPref.getSchoolID(),
            "studentID": await SharedPref.getStudentID(),
            "sessionID": await SharedPref.getSessionId(),
            "schoolURL": await SharedPref.getSchoolUrl(),
            "pageNumber": 0
          });
      CumulativeAttendanceModel cumulativeAttendanceResponse =
          cumulativeAttendanceModelFromJson(res.toString());
      return cumulativeAttendanceResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch Cumulative Attendance list: $e");
    }
  }

  ////////////////////////////////////////////////     LOG OUT       //////////////////////////////////////////////////////

  Future<dynamic> logOut() async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.signInLogout, isStagingLink: true, data: {
        "deviceToken":
            "cWG3o3r8R-WRIDh0lqWcGJ:APA91bG1WdxTuuYeiQkbbIN-24cCiejfBKFsU0x_2vde55fINGSoOGZmXD-479iD--hAJLJj4fOp_O2T9bydOL46zwy8q7nyfioUm3zFBogwW2QHXWo1XQEQZ4xYE-LOghv16MxHto93",
        "deviceType": 1,
        "userID": await SharedPref.getUserID(),
        "schoolID": await SharedPref.getSchoolID(),
        "studentID": await SharedPref.getStudentID(),
        "sessionID": await SharedPref.getSessionId(),
        "schoolURL": await SharedPref.getSchoolUrl(),
        "pageNumber": 8
      });
      dynamic signoutResponse = res;
      return signoutResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch Cumulative Attendance list: $e");
    }
  }

  ////////////////////////////////////////////////     GET CHANGE SESSION LIST       //////////////////////////////////////////////////////

  Future<List<ChangeSessionModel>> changeSession() async {
    try {
      // Make the API request
      final res = await _myService.networkPost(
        url: EndUrl.changeSession,
        isStagingLink: true,
        data: {
          "userID": await SharedPref.getUserID(),
          "schoolID": await SharedPref.getSchoolID(),
          "studentID": await SharedPref.getStudentID(),
          "sessionID": await SharedPref.getSessionId(),
          "schoolURL": await SharedPref.getSchoolUrl(),
          "pageNumber": 0,
        },
      );

      // Extract the data from the response
      final extractedData = res.data ?? res.body ?? res;

      // Log the extracted data and its type
      log("extracted data: $extractedData");
      log("extracted data type: ${extractedData.runtimeType}");

      // Check if the extracted data is a String and decode it
      if (extractedData is String) {
        List<dynamic> jsonData = json.decode(extractedData);

        List<ChangeSessionModel> changeSessionResponse =
            jsonData.map((item) => ChangeSessionModel.fromJson(item)).toList();

        return changeSessionResponse;
      }
      // Check if the extracted data is a List
      else if (extractedData is List) {
        List<ChangeSessionModel> changeSessionResponse = extractedData
            .map((item) => ChangeSessionModel.fromJson(item))
            .toList();

        return changeSessionResponse;
      }
      // Handle unexpected formats
      else {
        throw Exception(
            "Unexpected response format: ${extractedData.runtimeType}");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch change session list: $e");
    }
  }


 ////////////////////////////////////////////////    SEND FEEDBACK    //////////////////////////////////////////////////////


  Future<Map<String, String>> sendFeedback(
      String name, String email, String feedback) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.sendFeedback, isStagingLink: true, data: {
        "name": name,
        "emailID": email,
        "message": feedback,
        "userID": await SharedPref.getUserID(),
        "schoolID": await SharedPref.getSchoolID(),
        "studentID": await SharedPref.getStudentID(),
        "sessionID": await SharedPref.getSessionId(),
        "schoolURL": await SharedPref.getSchoolUrl(),
        "pageNumber": 0
      });

      Map<String, dynamic> response = res.data;
      Map<String, String> reservedResponse = {
        "responseCode": "${response["responseCode"]}",
        "responseMessage": "${response["responseMessage"]}"
      };
      return reservedResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to send feedback: $e");
    }
  }


   ////////////////////////////////////////////////    PUSH NOTIFICATION    //////////////////////////////////////////////////////


  Future<Map<String, String>> pushNotification(int isNotification) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.sendFeedback, isStagingLink: true, data: {
        "deviceType": 1,
        "deviceToken": "sample string 2",
        "isNotification": isNotification,
        "userID": await SharedPref.getUserID(),
        "schoolID": await SharedPref.getSchoolID(),
        "studentID": await SharedPref.getStudentID(),
        "sessionID": await SharedPref.getSessionId(),
        "schoolURL": await SharedPref.getSchoolUrl(),
        "pageNumber": 0
      });

      Map<String, dynamic> response = res.data;
      Map<String, String> reservedResponse = {
        "responseCode": "${response["responseCode"]}",
        "responseMessage": "${response["responseMessage"]}"
      };
      return reservedResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to set notification status: $e");
    }
  }
}
