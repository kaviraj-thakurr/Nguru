import 'dart:convert';
import 'dart:developer';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/assignment_models/assignment_month_list_model.dart';
import 'package:nguru/models/attendance_bar_chart_model.dart';
import 'package:nguru/models/attendence_model.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/models/forget_pass_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';
import 'package:nguru/models/get_fee_model.dart';
import 'package:nguru/models/library_book_search_model.dart';
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';
import 'package:nguru/models/notification_models.dart';
import 'package:nguru/models/particular_month_attendance_model.dart';
import 'package:nguru/models/push_notification_model.dart';
import 'package:nguru/models/reset_password_model.dart';
import 'package:nguru/repo/end_urls.dart';
import 'package:nguru/services/networking.dart';
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
        url: EndUrl.addSchool,
        data: {
          "schoolURL": fullSchoolUrl,
        },
      );
      AddSchoolModel addSchool = addSchoolFromJson(res.toString());
      return addSchool;
    } catch (e) {
      log(e.toString());
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
        url: EndUrl.logIn,
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
      log(e.toString());
      throw Exception("Failed to login: $e");
    }
  }

  //--------------------------this method for forgot password------------>//

  Future<ForgetPassWordModel> forgotPassword(String userName) async {
    try {
      final res =
          await _myService.networkPost(url: EndUrl.forgetPassword, data: {
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
      log(e.toString());
      throw Exception("Failed to login: $e");
    }
  }
  //-----------------------------this api method for dashboard Sreen----------->//

  Future<DashboardModel> dashboardGetList() async {
    try {
      final res =
          await _myService.networkPost(url: EndUrl.dashboardList, data: {
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
      log(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }

  ///-------------------this api method for notification count ----------------->

  Future<NotificationModel> notificationCount() async {
    try {
      final res = await _myService.networkPost(
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
      log(e.toString());
      throw Exception("Failed to fetch dashboard data: $e");
    }
  }

  Future<AttendanceData> fetchAttendanceData() async {
    try {
      final res = await _myService.networkPost(
        url: EndUrl.attendanceBarData,
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
      log(e.toString());
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
        url: EndUrl.assignmentCalendarList,
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
      log(e.toString());
      throw Exception(
          "Failed to get calender list on specific month to get the assignment status on perticular date: $e");
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
        url: EndUrl.assignmentList,
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
      log(e.toString());
      throw Exception("Failed to get current assignment list: $e");
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
        url: EndUrl.currentCircularList,
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
      log(e.toString());
      throw Exception("Failed to get current discipline list: $e");
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
          "schoolID": 1,
          "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
          "sessionID": 107,
          "studentID": 896,
          "subjectID": 0,
          "type": type ?? 0,
          "userID": "6135",
          "year": 0
        },
      );
      DisciplineModel currentDiciplineList =
          disciplineModelFromJson(res.toString());
      return currentDiciplineList;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to get current discipline list: $e");
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
      log(e.toString());
      throw Exception("Failed to get contact us info: $e");
    }
  }

  ////////////////////////////////////////////////     Gallery API      //////////////////////////////////////////////////////

  ///  staging url: https://qsstg.niiteducation.com/mobileappservice/Api/PhotoGallery/GetList/

  Future<GalleryPhotosModel> getGalleryPhotoList({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(
          isStagingLink: true,
          url: EndUrl.photoGalleryList,
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
      log(e.toString());
      throw Exception("Failed to fetch gallery items: $e");
    }
  }

  ////////////////////////////////////////////////     SIGNOUT API      //////////////////////////////////////////////////////

  Future<Map<String, String>> signout({
    int? pageNumber,
  }) async {
    try {
      final res = await _myService.networkPost(url: EndUrl.signInLogIn, data: {
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
      log(e.toString());
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
      final res =
          await _myService.networkPost(url: EndUrl.changeUpdatePassword, data: {
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
      log(e.toString());
      throw Exception("Failed to reset password: $e");
    }
  }

  ////////////////////////////////////////////////     PUSH NOTIFICATION API      //////////////////////////////////////////////////////

  Future<PushNotificationModel> pushNotification({
    int? pageNumber,
    required int? isNotification,
  }) async {
    try {
      final res =
          await _myService.networkPost(url: EndUrl.changeUpdatePassword, data: {
        {
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
        }
      });
      PushNotificationModel pushNotificationResponse =
          pushNotificationModelFromJson(res.toString());
      return pushNotificationResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to change push notification status: $e");
    }
  }

  ////////////////////////////////////////////////     GET ATTENDANCE BAR CHART DATA      //////////////////////////////////////////////////////

  Future<AttendanceBarChartModel> getAttendanceBarGraph({
    int? pageNumber,
    int? isNotification,
  }) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.attendanceGetBarChart, data: {
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
        "type": 1,
        "userID": "6135",
        "year": 0
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
      final res = await _myService
          .networkPost(url: EndUrl.attendanceGetMonthWise, data: {
        "appMessageID": 0,
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": monthNumber,
        "pageNumber": 0,
        "pageSize": 0,
        "schoolID": 1,
        "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
        "sessionID": 107,
        "studentID": 896,
        "subjectID": 0,
        "type": 0,
        "userID": "6135",
        "year": 2024
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
      final res = await _myService.networkPost(url: EndUrl.feeGetList, data: {
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
      final res =
          await _myService.networkPost(url: EndUrl.diciplineGetList, data: {
        "appMessageID": 0,
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": 7,
        "pageNumber": 1,
        "pageSize": 10,
        "schoolID": 1,
        "schoolUrl": "https://quickschool.niitnguru.com/demoschool",
        "sessionID": 107,
        "studentID": 896,
        "subjectID": 0,
        "type": type ?? 1,
        "userID": "6135",
        "year": 0
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
      final res =
          await _myService.networkPost(url: EndUrl.calendarEventGetList, data: {
        "appMessageID": 0,
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "messageTypeId": 0,
        "month": monthNumber,
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
      CalendarEventModel calendarEventModelResponse =
          calendarEventModelFromJson(res.toString());
      return calendarEventModelResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch calendar events list: $e");
    }
  }

  ////////////////////////////////////////////////     GET LIBRARY ISSUED BOOK LIST DATA      //////////////////////////////////////////////////////

  Future<LibraryIssuedBookModel> getLibraryIssuedBook() async {
    try {
      final res =
          await _myService.networkPost(url: EndUrl.libraryGetIssuedList, data: {
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
      });
      LibraryIssuedBookModel libraryIssuedBookListResponse =
          libraryIssuedBookModelFromJson(res.toString());
      return libraryIssuedBookListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library issued books list: $e");
    }
  }

  ////////////////////////////////////////////////     GET LIBRARY ISSUED BOOK LIST DATA      //////////////////////////////////////////////////////

  Future<LibraryHistoryModel> getLibraryHistory({int? monthNumber}) async {
    try {
      final res = await _myService
          .networkPost(url: EndUrl.libraryGetHistoryList, data: {
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
      });
      LibraryHistoryModel libraryHistoyListResponse =
          libraryHistoryModelFromJson(res.toString());
      return libraryHistoyListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library histoy list: $e");
    }
  }

  ////////////////////////////////////////////////     GET LIBRARY ISSUED BOOK LIST DATA      //////////////////////////////////////////////////////

  Future<LibrarySearchBookModel> getLibrarySearchList(
      {String? searchQuery}) async {
    try {
      final res =
          await _myService.networkPost(url: EndUrl.libraryGetSearchList, data: {
        "appMessageID": 0,
        "authorName": "",
        "bookName": "$searchQuery",
        "circularID": 0,
        "contentType": 0,
        "downloadAttachment": 0,
        "isNotification": 0,
        "keyword": "",
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
      });
      LibrarySearchBookModel libraryHistoyListResponse =
          librarySearchBookModelFromJson(res.toString());
      return libraryHistoyListResponse;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch library book search list: $e");
    }
  }
}
