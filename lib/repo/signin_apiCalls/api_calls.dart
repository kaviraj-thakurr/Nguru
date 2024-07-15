import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nguru/services/networking.dart';
import 'package:nguru/utils/app_const.dart';

import 'package:nguru/models/add_school_model.dart';
import 'package:nguru/models/login_model.dart';

class AuthRepo {
  final _myService = Networking();
  var userToken = "";

  Future<AddSchoolModel> addSchool(String schoolurl, String subDomain) async {
  // Concatenate the base URL and the subdomain
  String fullSchoolUrl = "$schoolurl$subDomain";
  
  try {
    final res = await _myService.networkPost(
      url: "https://quickschool.niitnguru.com/mobileappservice/Api/School/GetDetail/",
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
          "deviceToken":"cWG3o3r8R-WRIDh0lqWcGJ:APA91bG1WdxTuuYeiQkbbIN-24cCiejfBKFsU0x_2vde55fINGSoOGZmXD-479iD--hAJLJj4fOp_O2T9bydOL46zwy8q7nyfioUm3zFBogwW2QHXWo1XQEQZ4xYE-LOghv16MxHto93",
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

Future <dynamic> forgotPassword (String userName)async{
  try{
    final res = await _myService.networkPost(url: "https://quickschool.niitnguru.com/mobileappservice/Api/SignIn/ForgetPassword",
    data: {
      "userName": userName
    }
    );
  var result = json.decode(res.toString());
  return result;

  }catch(e){
     print(e.toString());
     throw Exception("Failed to login: $e");
  }


}

}
